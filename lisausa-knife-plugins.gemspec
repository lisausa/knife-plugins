# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lisausa_knife_plugins', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'lisausa-knife-plugins'
  maintainers = {
    'Ryan Taylor Long' => 'ryan.long@lisausa.net'
  }
  gem.authors       = maintainers.keys
  gem.email         = maintainers.values

  gem.description   = <<-DESC.gsub(/\s+/, ' ')
    These are plugins for the Chef utility `knife`, for use by LISAUSA employees
  DESC
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/lisausa/knife-plugins'

  gem.executables   = [] # `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']

  gem.version       = LisausaKnifePlugins::VERSION

  gem.add_dependency 'chef'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
end
