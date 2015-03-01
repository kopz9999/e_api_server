$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "e_api_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "e_api_server"
  s.version     = EApiServer::VERSION
  s.authors     = ["Kyoto Kopz"]
  s.email       = ["kopz9999@gmail.com"]
  s.homepage    = "https://github.com/kopz9999"
  s.summary     = "Simplifies the creation of a REST API Server."
  s.description = "Provides module to simplify the creation of an API Server."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", '~> 4.1', '>= 4.1.0'
  s.add_dependency 'kaminari', '~> 0.16', '>= 0.16.2'
  s.add_dependency 'jbuilder', '~> 2.0'

  s.add_development_dependency "sqlite3", "1.3.10"
  s.add_development_dependency "pry", "0.10.1"
  s.add_development_dependency "pry-nav", "0.2.4"
end
