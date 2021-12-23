# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dandelionapi/version'

Gem::Specification.new do |spec|
  spec.name          = "dandelionapi"
  spec.version       = Dandelionapi::VERSION
  spec.authors       = ["Andrea Mostosi"]
  spec.email         = ["andrea.mostosi@zenkay.net"]

  spec.summary       = %q{Ruby Gem for Dandelion API service}
  spec.description   = %q{Ruby Gem for Dandelion API service. Available endpoint: Entity Extraction, Text Similarity and Language Detection}
  spec.homepage      = "https://github.com/zenkay/dandelionapi-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "faraday", '~> 1.0', '>= 1.0.0'
  spec.add_dependency "faraday_middleware", '~> 1.0', '>= 1.0.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec","~> 3.3"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.21"
  spec.add_development_dependency "simplecov", "~> 0.10"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "yard", "~> 0.8"
end
