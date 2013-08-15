# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "telldus/version"

Gem::Specification.new do |s|
  s.name        = "telldus"
  s.version     = Telldus::VERSION
  s.authors     = ["Per-Kristian Nordnes"]
  s.email       = ["per.kristian.nordnes@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby gem for communicating with the Telldus TellStick and TellStick Duo}
  s.description = %q{FFI Wrapper for the tellduscore C library and helpers for communicating with the Tellsticks via Ruby}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"

  s.add_runtime_dependency "ffi"

end
