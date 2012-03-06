# -*- encoding: utf-8 -*-
require File.expand_path('../lib/trusted_attributes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ivan Navarrete and Jonas Nicklas"]
  gem.email         = ["dev@elabs.se"]
  gem.description   = %q{Mass assignment security in your controller, yo}
  gem.summary       = %q{Mass assignment security in your controller}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "trusted_attributes"
  gem.require_paths = ["lib"]
  gem.version       = TrustedAttributes::VERSION

  gem.add_runtime_dependency "rails", ["~> 3.0"]
end
