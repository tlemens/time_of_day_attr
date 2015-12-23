require 'test_helper'

class TimeOfDayAttrTest < ActiveSupport::TestCase
  
  test 'delocalize time of day' do
    assert_equal 36000, TimeOfDayAttr.delocalize('10:00')
    assert_equal 55800, TimeOfDayAttr.delocalize('15:30')
    assert_equal 61140, TimeOfDayAttr.delocalize('16:59')
    assert_equal 32400, TimeOfDayAttr.delocalize('9:00')
    assert_equal 32400, TimeOfDayAttr.delocalize('09:00')
    assert_equal 32400, TimeOfDayAttr.delocalize('9', format: :hour)
  end

  test 'localize time of day' do
    assert_equal ' 9:00', TimeOfDayAttr.localize(32400)
    assert_equal '14:45', TimeOfDayAttr.localize(53100)
  end

  test 'localize time of day and omit minutes at full hour' do
    assert_equal ' 9',      TimeOfDayAttr.localize(32400, omit_minutes_at_full_hour: true)
    assert_equal '14',      TimeOfDayAttr.localize(50400, omit_minutes_at_full_hour: true)
    assert_equal '14:45',   TimeOfDayAttr.localize(53100, omit_minutes_at_full_hour: true)
  end

  test 'localizing nil should return nil' do
    assert_nil TimeOfDayAttr.localize(nil)
  end

  test 'time of day attr setter should delocalize value' do
    business_hour = BusinessHour.new(opening: '9:00', closing: '17:00')
    assert_equal 32400, business_hour.opening
    assert_equal 61200, business_hour.closing
  end

  test 'time of day attr setter should delocalize hour formatted value' do
    business_hour = BusinessHour.new(opening: '9', closing: '17')
    assert_equal 32400, business_hour.opening
    assert_equal 61200, business_hour.closing
  end

  test 'time of day attr setter should ignore invalid formats' do
    business_hour = BusinessHour.new(opening: 'Nine', closing: 'Five')
    assert_nil business_hour.opening
    assert_nil business_hour.closing
    business_hour.opening = '9'
    assert_equal 32400, business_hour.opening
    business_hour.opening = 'Nine'
    assert_nil business_hour.opening
    business_hour.opening = '9:30'
    assert_equal 34200, business_hour.opening
    business_hour.opening = 55800
    assert_equal 55800, business_hour.opening
    business_hour.opening = nil
    assert_nil business_hour.opening
    business_hour.opening = '25:00'
    assert_nil business_hour.opening
    business_hour.opening = '24:30'
    assert_nil business_hour.opening
  end


  test '24 should be usable' do
    business_hour = BusinessHour.new(opening: '0', closing: '24')
    assert_equal 0, business_hour.opening
    assert_equal 86400, business_hour.closing
    assert_equal ' 0:00', TimeOfDayAttr.localize(business_hour.opening)
    assert_equal '24:00', TimeOfDayAttr.localize(business_hour.closing)
    assert_equal ' 0', TimeOfDayAttr.localize(business_hour.opening, omit_minutes_at_full_hour: true)
    assert_equal '24', TimeOfDayAttr.localize(business_hour.closing, omit_minutes_at_full_hour: true)
  end

end
