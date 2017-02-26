class BusinessHour < ActiveRecord::Base
  attr_reader :opening_value, :closing_value
  time_of_day_attr :opening
  time_of_day_attr :closing, prepend: true

  def opening=(value)
    @opening_value = value
    super(value)
  end

  def closing=(value)
    @closing_value = value
    super(value)
  end
end
