require 'test_helper'

class TimeOfDayAttrTest < ActiveSupport::TestCase
  context '::localize' do
    should 'convert seconds to time of day' do
      assert_equal ' 9:00', TimeOfDayAttr.localize(32_400)
      assert_equal '14:45', TimeOfDayAttr.localize(53_100)
    end

    should 'omit minutes at full hour' do
      assert_equal ' 9',      TimeOfDayAttr.localize(32_400, omit_minutes_at_full_hour: true)
      assert_equal '14',      TimeOfDayAttr.localize(50_400, omit_minutes_at_full_hour: true)
      assert_equal '14:45',   TimeOfDayAttr.localize(53_100, omit_minutes_at_full_hour: true)
    end

    should 'convert nil to nil' do
      assert_nil TimeOfDayAttr.localize(nil)
    end

    should 'support 24 hours' do
      assert_equal ' 0:00', TimeOfDayAttr.localize(0)
      assert_equal '24:00', TimeOfDayAttr.localize(86_400)
      assert_equal ' 0', TimeOfDayAttr.localize(0, omit_minutes_at_full_hour: true)
      assert_equal '24', TimeOfDayAttr.localize(86_400, omit_minutes_at_full_hour: true)
    end
  end

  context '::delocaize' do
    should 'convert time of day to seconds' do
      assert_equal 36_000, TimeOfDayAttr.delocalize('10:00')
      assert_equal 55_800, TimeOfDayAttr.delocalize('15:30')
      assert_equal 61_140, TimeOfDayAttr.delocalize('16:59')
      assert_equal 32_400, TimeOfDayAttr.delocalize('9:00')
      assert_equal 32_400, TimeOfDayAttr.delocalize('09:00')
      assert_equal 32_400, TimeOfDayAttr.delocalize('9', formats: [:hour])
    end

    should 'convert out of range time of day to nil' do
      assert_nil TimeOfDayAttr.delocalize('25:00')
      assert_nil TimeOfDayAttr.delocalize('24:30')
    end
  end
end
