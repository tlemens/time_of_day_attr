require 'test_helper'

module TimeOfDayAttr
  class TimeOfDayTest < ActiveSupport::TestCase
    context '::convert_to_seconds' do
      should 'convert time of day to seconds' do
        assert_equal 36_000, TimeOfDay.convert_to_seconds('10:00')
        assert_equal 55_800, TimeOfDay.convert_to_seconds('15:30')
        assert_equal 61_140, TimeOfDay.convert_to_seconds('16:59')
        assert_equal 32_400, TimeOfDay.convert_to_seconds('9:00')
        assert_equal 32_400, TimeOfDay.convert_to_seconds('09:00')
        assert_equal 32_400, TimeOfDay.convert_to_seconds('9', formats: [:hour])
      end

      should 'convert out of range time of day to nil' do
        assert_nil TimeOfDay.convert_to_seconds('25:00')
        assert_nil TimeOfDay.convert_to_seconds('24:30')
      end
    end
  end
end
