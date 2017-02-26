require 'test_helper'
require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
require_relative 'schema'
require_relative 'models/business_hour'

class ActiveRecordExtTest < ActiveSupport::TestCase
  context 'time of day value' do
    setup do
      @business_hour = BusinessHour.new(opening: '9:00', closing: '17:00')
    end

    should 'be converted to seconds since midnight' do
      assert_equal 32400, @business_hour.opening
      assert_equal 61200, @business_hour.closing
    end
  end
    
  context 'hour formatted time of day value' do
    setup do
      @business_hour = BusinessHour.new(opening: '9', closing: '17')
    end
    
    should 'be converted to seconds since midnight' do
      assert_equal 32400, @business_hour.opening
      assert_equal 61200, @business_hour.closing
    end
  end

  context 'unsupported time of day value' do
    setup do
      @business_hour = BusinessHour.new(opening: 55800)
      @business_hour.opening = 'Nine'
    end

    should 'be converted to nil' do
      assert_nil @business_hour.opening
    end
  end

  context 'non string value' do
    setup do
      @business_hour = BusinessHour.new(opening: 55800)
    end

    should 'not be converted' do
      assert_equal 55800, @business_hour.opening
    end
  end

  context 'prepend option' do
    setup do
      @business_hour = BusinessHour.new(opening: '9', closing: '9')
    end

    should 'be supported' do
      assert_equal '9', @business_hour.opening_value
      assert_equal 32400, @business_hour.closing_value
    end
  end
end
