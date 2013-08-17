# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tellstickr/version"

Gem::Specification.new do |s|
  s.name        = "tellstickr"
  s.version     = TellStickR::VERSION
  s.authors     = ["Per-Kristian Nordnes"]
  s.email       = ["per.kristian.nordnes@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Gem for communicating with the Telldus TellStick and TellStick Duo through the official telldus-core C library in Ruby.}
  s.description = %q{FFI wrapper for the telldus-core C library, and classes for easy communication with various devices and sensors.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"

  s.add_runtime_dependency "ffi"

end
