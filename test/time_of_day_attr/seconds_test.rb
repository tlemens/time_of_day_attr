require 'test_helper'

module TimeOfDayAttr
  class TimeOfDayTest < ActiveSupport::TestCase
    context '::convert_to_time_of_day' do
      should 'convert seconds to time of day' do
        assert_equal ' 9:00', Seconds.convert_to_time_of_day(32_400)
        assert_equal '14:45', Seconds.convert_to_time_of_day(53_100)
      end

      should 'omit minutes at full hour' do
        assert_equal ' 9',    Seconds.convert_to_time_of_day(32_400, omit_minutes_at_full_hour: true)
        assert_equal '14',    Seconds.convert_to_time_of_day(50_400, omit_minutes_at_full_hour: true)
        assert_equal '14:45', Seconds.convert_to_time_of_day(53_100, omit_minutes_at_full_hour: true)
      end

      should 'convert nil to nil' do
        assert_nil Seconds.convert_to_time_of_day(nil)
      end

      should 'support 24 hours' do
        assert_equal ' 0:00', Seconds.convert_to_time_of_day(0)
        assert_equal '24:00', Seconds.convert_to_time_of_day(86_400)
        assert_equal ' 0', Seconds.convert_to_time_of_day(0, omit_minutes_at_full_hour: true)
        assert_equal '24', Seconds.convert_to_time_of_day(86_400, omit_minutes_at_full_hour: true)
      end
    end
  end
end
