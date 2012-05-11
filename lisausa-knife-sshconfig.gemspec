# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lisausa-knife-sshconfig', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'lisausa-knife-sshconfig'
  maintainers = {
    'Ryan Taylor Long' => 'ryan.long@lisausa.net'
  }
  gem.authors       = maintainers.keys
  gem.email         = maintainers.values

  gem.description   = <<-DESC.gsub(/\s+/, ' ')
    This is a plugin for Knife that helps grab all nodes within the LISA cloud and presents you with
    a chunk of .ssh/config that provides host name mapping. This has the bonus of allowing for tab
    completion, as well.
  DESC
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/lisausa/lisausa-knife-sshconfig'

  gem.executables   = [] # `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']

  gem.version       = LisaUSA::SetupSsh::VERSION

  gem.add_dependency 'chef', '~> 0.10'

  gem.add_development_dependency 'rake'
end
