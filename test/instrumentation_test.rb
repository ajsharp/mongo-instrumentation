require 'test_helper'

class MongoInstrumentationTest < MiniTest::Unit::TestCase
  def setup
    @drain   = StringIO.new
    @logger  = Logger.new(@drain)

    MongoInstrumentation.configure do |config|
      config.caller = false
    end

    @db      = Mongo::Connection.new(nil, nil, logger: @logger).db('mongo-instrumentation-test')
    @widgets = @db['widgets']
  end

  def test_instrument_output_without_config
    @widgets.count
    @drain.rewind
    assert_nil @drain.read.match(/caller=/)
  end

  def test_not_for_writes
    old_count = @widgets.count
    @widgets.insert({'foo' => 'bar'})
    assert_equal @widgets.count, old_count + 1
  end

  def test_caller_output
    MongoInstrumentation.configure do |config|
      config.caller = true
    end

    @widgets.count
    @drain.rewind
    assert_match /caller=/, @drain.read
  end

  def test_explain_output
    MongoInstrumentation.configure do |config|
      config.caller  = false
      config.explain_threshold = 0.0
    end

    @widgets.count()
    @drain.rewind
    assert_match /explain=/, @drain.read
  end
end
