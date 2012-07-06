# -*- encoding: utf-8 -*-
require File.expand_path('../lib/Hokkaido/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Keyvan"]
  gem.email         = ["keyvan@keyvanfatehi.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "Hokkaido"
  gem.require_paths = ["lib"]
  gem.version       = Hokkaido::VERSION
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_runtime_dependency 'ruby_parser'
end
