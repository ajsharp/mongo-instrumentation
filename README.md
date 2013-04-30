## What

This gem adds additional information to the mongo ruby driver logging output. Specifically:

* Support for including `explain()` information in log output
* Support for backtrace information in log output

## How

This gem monkey-patches the `Mongo::Logging#log_operation` method.

## Usage

```ruby
MongoInstrumentation.configure do |config|
  # include a stacktrace of your app's calling code in the log output
  config.caller = true 

  # Run an explain operation and append the results to the log output
  # for queries that take longer than this threshold
  config.explain_threshold = 1500 # in ms
end
```

## Contributing

Run the tests by running `rake`.
