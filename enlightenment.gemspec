$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enlightenment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enlightenment"
  s.version     = Enlightenment::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Enlightenment."
  s.description = "TODO: Description of Enlightenment."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "green_light"
  s.add_dependency "jquery-rails" # for now.

  s.add_development_dependency "sqlite3"
end
