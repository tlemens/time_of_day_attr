class BusinessHour < ActiveRecord::Base
  attr_reader :tracked_opening, :tracked_closing

  time_of_day_attr :opening
  time_of_day_attr :closing, prepend: true

  def opening=(value)
    @tracked_opening = value
    super(value)
  end

  def closing=(value)
    @tracked_closing = value
    super(value)
  end
end
