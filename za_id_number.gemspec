# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'za_id_number/version'

Gem::Specification.new do |spec|
  spec.name          = "za_id_number"
  spec.version       = ZAIDNumber::Version::VERSION
  spec.authors       = ["Gabriel Fortuna"]
  spec.email         = ["gabriel@zero-one.io"]

  spec.summary       = "A small library for parsing South African ID numbers"
  spec.description   = "A small library for parsing, validating, and providing information on South African ID numbers"
  spec.homepage      = "http://www.zero-one.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler',       '~> 1.13'
  spec.add_development_dependency 'rake',          '~> 10.0'
  spec.add_development_dependency 'rspec',         '~> 3.0'
  spec.add_development_dependency 'pry',           '~> 0.11.3'
  spec.add_development_dependency 'awesome_print', '~> 1.8'

  spec.add_dependency 'luhn', '~> 1.0', '>= 1.0.2'
end
