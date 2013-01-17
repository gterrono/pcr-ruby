# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pcr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = "Matt Parmett, Greg Terrono"
  gem.email         = "terronogr@gmail.com"
  gem.description   = %q{Ruby wrapper for the Penn Course Review API}
  gem.summary       = %q{Ruby wrapper for the Penn Course Review API}
  gem.homepage      = "https://github.com/gterrono/pcr-ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pcr"
  gem.require_paths = ["lib"]
  gem.version       = PCR::Ruby::VERSION
  
  gem.add_dependency "json"
end
