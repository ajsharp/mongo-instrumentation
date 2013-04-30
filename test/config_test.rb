require 'test_helper'

class MongoInstrumentationConfigTest < MiniTest::Unit::TestCase
  def test_explain_false_when_false_threshold
    MongoInstrumentation.configure { |c| c.explain_threshold = false }
    assert !MongoInstrumentation.config.explain?

    MongoInstrumentation.configure { |c| c.explain_threshold = 1 }
    assert MongoInstrumentation.config.explain?
  end
end
