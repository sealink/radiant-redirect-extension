# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'radiant-redirect-extension/version'

Gem::Specification.new do |spec|
  spec.name          = 'radiant-redirect-extension'
  spec.version       = RadiantRedirectExtension::VERSION
  spec.authors       = ['Alessandro Berardi']
  spec.email         = ['support@travellink.com.au']
  spec.summary       = "This extensions looks for a 'redirect_url' page field and uses it to perform a 302 redirect"
  spec.description   = 'See README for full details on how to install, use, etc.'
  spec.homepage      = 'http://github.com/sealink/radiant-redirect-extension/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'radius'
  spec.add_dependency 'radiant_extension_helper'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.0'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'simplecov'
end
