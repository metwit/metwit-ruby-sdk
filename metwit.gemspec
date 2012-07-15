# -*- encoding: utf-8 -*-
require File.expand_path('../lib/metwit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Simone D'Amico"]
  gem.email         = ["sim@me.com"]
  gem.description   = %q{Ruby SDK for Metwit public APIs}
  gem.summary       = %q{Ruby SDK for Metwit public APIs}
  gem.homepage      = "http://metwit.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "metwit"
  gem.require_paths = ["lib"]
  gem.version       = Metwit::VERSION
  gem.add_dependency('httparty')
end
