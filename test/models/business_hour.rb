class BusinessHour < ActiveRecord::Base
  time_of_day_attr :opening, :closing
end
