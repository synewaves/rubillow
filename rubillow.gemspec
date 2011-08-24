# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubillow/version"

Gem::Specification.new do |s|
  s.name        = "rubillow"
  s.version     = Rubillow::VERSION
  s.authors     = ["Matthew Vince"]
  s.email       = ["rubillow@matthewvince.com"]
  s.homepage    = "https://github.com/synewaves/rubillow"
  s.summary     = %q{Ruby library to access the Zilow API}
  s.description = %q{Provides easy access to the Zillow API using Ruby}

  s.rubyforge_project = "rubillow"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.6"
  # s.add_runtime_dependency "rest-client"
end
