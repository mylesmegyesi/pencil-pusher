# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "pencil_pusher"
  gem.version       = '0.0.1'
  gem.authors       = ["Myles Megyesi"]
  gem.email         = ["myles.megyesi@gmail.com"]
  gem.description   = 'Form builder and validator'
  gem.summary       = 'Form builder and validator'

  gem.files         = Dir['lib/**/*.rb']
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'activemodel', '~> 4.0.0'
  gem.add_runtime_dependency     'virtus',      '~> 1.0.0beta6'
  gem.add_development_dependency 'rake',        '~> 10.1.0'
  gem.add_development_dependency 'rspec',       '~> 2.14.1'
end
