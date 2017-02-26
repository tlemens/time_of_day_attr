module TimeOfDayAttr
  TimeOfDay = Struct.new(:value) do
    def to_seconds(time_format)
      time  = Time.strptime(value, time_format)
      # Switch to beginning of year to prevent wrong conversion on the day of time change
      # see https://en.wikipedia.org/wiki/Daylight_saving_time
      time = time.change(month: 1, day: 1)

      seconds = time.seconds_since_midnight.to_i

      if seconds.zero? && value.starts_with?('24')
        24.hours.to_i
      else
        seconds
      end
    end
  end
end
