# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'time_of_day_attr'
  s.version     = '3.0.0'
  s.authors     = ['Clemens Teichmann']
  s.email       = ['clemens_t@web.de']
  s.homepage    = 'https://github.com/clemenst/time_of_day_attr'
  s.summary     = 'Time of day attributes for your Rails model'
  # rubocop:disable Metrics/LineLength
  s.description = 'This ruby gem converts time of day to seconds (since midnight) and back. The value in seconds can be used for calculations and validations.'
  # rubocop:enable Metrics/LineLength
  s.files = Dir['{config,lib}/**/*'] + ['Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.license = 'MIT'

  s.add_dependency 'i18n', '>= 0.7'

  s.add_development_dependency 'sqlite3'
end
