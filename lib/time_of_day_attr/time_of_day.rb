module TimeOfDayAttr
  module TimeOfDay
    def self.convert_to_seconds(time_of_day, options = {})
      formats = options[:formats] || DEFAULT_FORMATS
      catch(:out_of_range) do
        formats.each do |format|
          time_format = TimeFormat.translate_format(format)
          seconds = time_of_day_to_seconds(time_of_day, time_format)
          return seconds if seconds
        end
      end
      nil
    end

    def self.omit_minutes_at_full_hour(time_of_day)
      time_of_day.end_with?('00') ? time_of_day[0...-3] : time_of_day
    end

    def self.seconds_since_midnight(time_of_day, time)
      seconds = time.seconds_since_midnight
      seconds = 24.hours if time_of_day_24_00?(time_of_day, seconds)
      seconds.to_i
    end
    private_class_method :seconds_since_midnight

    def self.time_of_day_24_00?(time_of_day, seconds)
      time_of_day.starts_with?('24') && seconds.zero?
    end
    private_class_method :time_of_day_24_00?

    def self.time_of_day_to_seconds(time_of_day, time_format)
      time = time_of_day_to_time(time_of_day, time_format)
      return unless time
      seconds_since_midnight(time_of_day, time)
    end
    private_class_method :time_of_day_to_seconds

    def self.time_of_day_to_time(time_of_day, time_format)
      time = Time.strptime(time_of_day, time_format)
      # Switch to beginning of year to prevent wrong conversion on the day of time change
      # see https://en.wikipedia.org/wiki/Daylight_saving_time
      time.change(month: 1, day: 1)
    rescue ArgumentError => e
      throw(:out_of_range) if e.message.include?('out of range')
    end
    private_class_method :time_of_day_to_time
  end
end
