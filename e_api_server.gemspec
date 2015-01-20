$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "e_api_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "e_api_server"
  s.version     = EApiServer::VERSION
  s.authors     = ["Kyoto Kopz"]
  s.email       = ["kopz9999@gmail.com"]
  s.homepage    = "http://bitbucket.org/kkyoto/"
  s.summary     = "Simplifies the creation of an API Server."
  s.description = "Provides module to simplify the creation of an API Server."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
