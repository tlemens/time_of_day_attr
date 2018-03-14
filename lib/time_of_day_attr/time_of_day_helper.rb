module TimeOfDayAttr
  module TimeOfDayHelper
    def delocalize(time_of_day, options = {})
      formats = options[:formats] || DEFAULT_FORMATS
      catch(:time_of_day_invalid) do
        formats.each do |format|
          seconds = time_of_day_to_seconds(time_of_day, time_format(format))
          return seconds if seconds
        end
      end
      nil
    end

    private

    def seconds_since_midnight(time_of_day, time)
      seconds = time.seconds_since_midnight
      seconds = 24.hours if time_of_day_24_00?(time_of_day, seconds)
      seconds.to_i
    end

    def time_of_day_24_00?(time_of_day, seconds)
      time_of_day.starts_with?('24') && seconds.zero?
    end

    def time_of_day_to_seconds(time_of_day, time_format)
      time = time_of_day_to_time(time_of_day, time_format)
      return unless time
      seconds_since_midnight(time_of_day, time)
    end

    def time_of_day_to_time(time_of_day, time_format)
      time = Time.strptime(time_of_day, time_format)
      # Switch to beginning of year to prevent wrong conversion on the day of time change
      # see https://en.wikipedia.org/wiki/Daylight_saving_time
      time.change(month: 1, day: 1)
    rescue ArgumentError => e
      throw(:time_of_day_invalid) if e.message.include?('out of range')
    end
  end
end
