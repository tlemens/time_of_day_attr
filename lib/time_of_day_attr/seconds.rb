module TimeOfDayAttr
  module Seconds
    def self.convert_to_time_of_day(value, options = {})
      return value unless value.respond_to?(:seconds)

      format = options[:format] || DEFAULT_FORMATS.first
      time_format = TimeFormat.translate_format(format)

      time_of_day = seconds_to_time_of_day(value, time_format)
      if options[:omit_minutes_at_full_hour]
        TimeOfDay.omit_minutes_at_full_hour(time_of_day)
      else
        time_of_day
      end
    end

    def self.seconds_to_time_of_day(value, time_format)
      # Switch to beginning of year to prevent wrong conversion on the day of time change
      # see https://en.wikipedia.org/wiki/Daylight_saving_time
      time = Time.current.beginning_of_year.at_midnight + value.seconds

      time_of_day = time.strftime(time_format)

      if 24.hours.to_i == value
        time_of_day.gsub(' 0', '24')
      else
        time_of_day
      end
    end
    private_class_method :seconds_to_time_of_day
  end
end
