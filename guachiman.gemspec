# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guachiman/version'

Gem::Specification.new do |spec|
  spec.name          = 'guachiman'
  spec.version       = Guachiman::VERSION
  spec.authors       = ['Francesco Rodriguez', 'Gustavo Beathyate']
  spec.email         = ['lrodriguezsanc@gmail.com', 'gustavo.bt@me.com']
  spec.summary       = 'Basic authorization library'
  spec.description   = "#{spec.summary} based on Ryan Bates' Railscasts #385 and #386"
  spec.homepage      = 'https://github.com/goddamnhippie/guachiman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'railties',     '~> 4.0', '>= 4.0.0'
  spec.add_dependency 'activerecord', '~> 4.0', '>= 4.0.0'

  spec.add_development_dependency 'rake', '~> 10.3.2'

  spec.add_development_dependency 'minitest', '~> 5.3', '>= 5.3.3'
  spec.add_development_dependency 'bundler',  '~> 1.6', '>= 1.6.0'
end
