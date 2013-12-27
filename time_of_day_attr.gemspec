$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "time_of_day_attr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "time_of_day_attr"
  s.version     = TimeOfDayAttr::VERSION
  s.authors     = ["Clemens Teichmann"]
  s.email       = ["clemens_t@web.de"]
  s.homepage    = "https://github.com/clemenst/time_of_day_attr"
  s.summary     = "Convert time of day to seconds since midnight and back."
  s.description = "Adds time_of_day_attr to your models. Will try to convert time of day to seconds since midnight when a string was set. Localized formats for conversation can be added to your translation files. TimeOfDayAttr.localize converts seconds since midnight back to time of day."
  s.files = Dir["{config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"

  s.add_development_dependency "sqlite3"
end
