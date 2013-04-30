## What

This gem adds additional information to the mongo ruby driver logging output. Specifically:

* Support for including `explain()` information in log output
* Support for backtrace information in log output

**IMPORTANT**: This gem should be considered *very experimental*. Take
  caution when considering using this gem in production.

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

logger = Logger.new($stdout)
db = Mongo::Connection.new(nil, nil, logger: logger).db('test_db')

# perform some query that takes longer than 1500 ms to complete
db['people'].find()

# In your logs, you'll see something like this

MONGODB (16ms) test_db['people'].find({})
        caller=/path/to/app/code/app/models/person.rb:95:in `block in <class:Person>'
        explain={"cursor":"BasicCursor","nscanned":13339,"nscannedObjects":13339,"n":12,"scanAndOrder":true,"millis":14,"nYields":0,"nChunkSkips":0,"isMultiKey":false,"indexOnly":false,"indexBounds":{},"allPlans":[{"cursor":"BasicCursor","indexBounds":{}}],"oldPlan":{"cursor":"BasicCursor","indexBounds":{}}}
```

## Contributing

Run the tests by running `rake`.
