# frozen_string_literal: true

require_relative 'lib/enginn/version'

Gem::Specification.new do |spec|
  spec.name          = 'enginn'
  spec.version       = Enginn::VERSION
  spec.authors       = 'Rémi Durieu'
  spec.summary       = 'Enginn API wrapper'
  spec.files         = Dir['**/**'].grep_v(/.gem$/)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '3.0'
end
