# -*- encoding: utf-8 -*-
require File.expand_path('../lib/Hokkaido/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jonathan Silverman", "Keyvan Fatehi"]
  gem.email         = ["jsilver@mdks.org", "keyvan@mdks.org"]
  gem.description   = %q{Automates as much as possible in assistance with porting of gems to RubyMotion}
  gem.summary       = %q{Automates as much as possible in assistance with porting of gems to RubyMotion}
  gem.homepage      = "https://github.com/jsilverMDX/Hokkaido"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "Hokkaido"
  gem.require_paths = ["lib"]
  gem.version       = Hokkaido::VERSION
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'pry-debugger'
  gem.add_runtime_dependency 'ruby_parser'
  gem.add_runtime_dependency 'commander'
end
