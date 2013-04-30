require 'mongo'
require 'mongo/instrumentation/logging'

module MongoInstrumentation
  class Configuration < Struct.new(:caller, :explain, :explain_threshold)
    def explain?
      !!self[:explain_threshold]
    end
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure(&block)
    @config = Configuration.new
    yield(@config)
  end
end
