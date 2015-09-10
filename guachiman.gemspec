# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guachiman/version'

Gem::Specification.new do |spec|
  spec.name          = 'guachiman'
  spec.version       = Guachiman::VERSION
  spec.authors       = ['Francesco Rodriguez', 'Gustavo Beathyate']
  spec.email         = ['lrodriguezsanc@gmail.com', 'gustavo.bt@me.com']
  spec.summary       = 'Minimal authorization'
  spec.description   = "#{ spec.summary } library"
  spec.homepage      = 'https://github.com/goddamnhippie/guachiman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.2'

  spec.add_development_dependency 'rake',     '~> 10.4', '>= 10.4.2'
  spec.add_development_dependency 'minitest', '~> 5.8',  '>= 5.8.0'
  spec.add_development_dependency 'bundler',  '~> 1.10', '>= 1.10.6'
end
