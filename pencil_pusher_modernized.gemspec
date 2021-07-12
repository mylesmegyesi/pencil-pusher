# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = 'pencil_pusher_modernized'
  gem.version       = '2.0.0'
  gem.authors       = ['Myles Megyesi', 'Steve Kim', 'Sarah Sunday']
  gem.description   = 'Form builder and validator'
  gem.summary       = 'Form builder and validator'

  gem.files         = Dir['lib/**/*.rb']
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'activemodel', '>= 6.0.0'
  gem.add_runtime_dependency     'virtus',      '~> 2.0.0'
  gem.add_development_dependency 'pry',         '~> 0.14.1'
  gem.add_development_dependency 'rake',        '~> 13.0.6'
  gem.add_development_dependency 'rspec',       '~> 3.10.0'
end
