module TimeOfDayAttr
  Seconds = Struct.new(:value) do
    def to_time_of_day(time_format)
      # Switch to beginning of year to prevent wrong conversion on the day of time change
      # see https://en.wikipedia.org/wiki/Daylight_saving_time
      time = Time.now.beginning_of_year.at_midnight + value.seconds
      
      time_of_day = time.strftime(time_format)
      
      if 24.hours.to_i == value
        time_of_day.gsub(' 0', '24')
      else
        time_of_day
      end
    end
  end
end
