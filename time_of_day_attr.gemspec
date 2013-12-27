$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "time_of_day_attr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "time_of_day_attr"
  s.version     = TimeOfDayAttr::VERSION
  s.authors     = ["Clemens Teichmann"]
  s.email       = ["clemens_t@web.de"]
  s.homepage    = ""
  s.summary     = "Store time of day as seconds since midnight"
  s.description = "Convert time of day to seconds since midnight and back. Formats can be defined in your translation files. To enable autoconverting use time_of_day_attr in your models."
  s.files = Dir["{config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"

  s.add_development_dependency "sqlite3"
end
