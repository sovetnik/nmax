$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'nmax/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'nmax'
  s.version     = Nmax::VERSION
  s.authors     = ['sovetnik']
  s.email       = ['sovetnik@oblaka.biz']
  s.homepage    = 'https://github.com/sovetnik'
  s.summary     = 'Summary of Nmax.'
  s.description = 'Description of Nmax.'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = ['nmax']
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
