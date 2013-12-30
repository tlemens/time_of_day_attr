# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'active_record'
require 'test/unit'
require 'time_of_day_attr'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

require File.expand_path('../schema', __FILE__)

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require f }
