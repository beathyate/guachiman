# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guachiman/version'

Gem::Specification.new do |spec|
  spec.name          = 'guachiman'
  spec.version       = Guachiman::VERSION
  spec.authors       = ['Francesco Rodriguez', 'Gustavo Beathyate']
  spec.email         = ['lrodriguezsanc@gmail.com', 'gustavo@epiclabs.pe']
  spec.summary       = 'Basic authorization library'
  spec.description   = spec.summary << ' inspired in Ryan Bates code'
  spec.homepage      = 'https://github.com/epiclabs/guachiman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
