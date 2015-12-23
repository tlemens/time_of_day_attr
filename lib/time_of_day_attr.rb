require 'time_of_day_attr/active_record_ext'
require 'action_view'
require 'time_of_day_attr/form_builder_ext'

files = Dir[File.join(File.dirname(__FILE__), '../config/locales/*.yml')]
I18n.load_path.concat(files)

module TimeOfDayAttr

  class << self

    def delocalize(value, options = {})
      format  = options[:format] || :default
      format  = translate_format(format) if format.is_a?(Symbol)
      time    = Time.strptime(value, format).change(month: 1, day: 1)
      seconds = time.seconds_since_midnight.to_i
      if seconds.zero? && value.starts_with?('24')
        24.hours.to_i
      else
        seconds
      end
    end

    def localize(value, options = {})
      return value unless value.respond_to?(:seconds)
      format  = options[:format] || :default
      format  = translate_format(format) if format.is_a?(Symbol)
      time    = Time.now.beginning_of_year.at_midnight + value.seconds
      time_of_day = time.strftime(format)
      if 24.hours.to_i == value
        time_of_day.gsub!(' 0', '24')
      end
      if options[:omit_minutes_at_full_hour]
        if time_of_day.end_with?('00')
          time_of_day = time_of_day[0...-3]
        end
      end
      time_of_day
    end
    alias :l :localize

    private

    def translate_format(format)
      I18n.translate("time_of_day.formats.#{format}")
    end

  end

end
