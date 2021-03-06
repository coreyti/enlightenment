$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enlightenment/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enlightenment"
  s.version     = Enlightenment::VERSION
  s.authors     = ["Corey Innis"]
  s.email       = ["corey@coolerator.net"]
  s.homepage    = "https://github.com/coreyti/enlightenment"
  s.summary     = "WIP: Enlightenment."
  s.description = "WIP: Enlightenment."

  s.files       = `git ls-files`.split($\)
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  # s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency "green_light"
  s.add_dependency "i18n-js"
  s.add_dependency "jquery-rails" # for now.

  s.add_development_dependency "capybara"
  s.add_development_dependency "coffee-script"
  s.add_development_dependency "jasmine"
  s.add_development_dependency "jasminerice"
  s.add_development_dependency "jasminerice-runner"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
