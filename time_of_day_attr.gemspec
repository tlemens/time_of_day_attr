$:.push File.expand_path("../lib", __FILE__)

require 'time_of_day_attr/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "time_of_day_attr"
  s.version     = TimeOfDayAttr::VERSION
  s.authors     = ["Clemens Teichmann"]
  s.email       = ["clemens_t@web.de"]
  s.homepage    = "https://github.com/clemenst/time_of_day_attr"
  s.summary     = "Time of day attributes for your Rails model"
  s.description = "This ruby gem converts time of day to seconds since midnight and back. The seconds value is stored in the database and can be used for calculations and validations."
  s.files = Dir["{config,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.14"

  s.add_development_dependency "sqlite3"
end
