# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongo-instrumentation/version"

Gem::Specification.new do |s|
  s.name        = "mongo-instrumentation"
  s.version     = MongoInstrumentation::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/mongo-instrumentation"
  s.summary     = %q{Instrumentation tools for the mongo ruby driver.}
  s.description = %q{Instrumentation tools for the mongo ruby driver.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'multi_json'
  s.add_dependency 'mongo'
end
