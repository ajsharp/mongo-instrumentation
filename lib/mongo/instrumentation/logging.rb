module Mongo
  module Logging
    protected

    # Override of of method defined by the mongo ruby driver
    # This gets called by the `instrument` method.
    # @override
    def log_operation(name, payload, start_time)
      @logger && @logger.debug do
        msg = "MONGODB "

        runtime = ((Time.now - start_time) * 1000).to_i
        msg << "(#{runtime}ms) "
        msg << "#{payload[:database]}['#{payload[:collection]}'].#{name}("
        msg << payload.values_at(:selector, :document, :documents, :fields ).compact.map(&:inspect).join(', ') + ")"
        msg << ".skip(#{payload[:skip]})"   if payload[:skip]
        msg << ".limit(#{payload[:limit]})" if payload[:limit]
        msg << ".sort(#{payload[:order]})"  if payload[:order]

        # filter out gems and ruby stdlib
        if MongoInstrumentation.config.caller
          filtered_caller = caller.reject { |line| line =~ /gems|rubies|#{$0}|irb/ }.join("\n\t")
          msg << "\n\tcaller=#{filtered_caller}"
        end

        if name == :find && MongoInstrumentation.config.explain? && runtime >= MongoInstrumentation.config.explain_threshold
          Thread.current[:stack_depth] ||= 0
          Thread.current[:stack_depth] += 1

          if respond_to?(:explain) && Thread.current[:stack_depth] < 2
            msg << "\nexplain=#{explain}"
          end
          Thread.current[:stack_depth] -= 1
        end

        msg
      end
    end
  end
end
