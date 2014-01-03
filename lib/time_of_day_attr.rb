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
      time    = Time.strptime(value, format)
      time.seconds_since_midnight.to_i
    end

    def localize(value, options = {})
      format  = options[:format] || :default
      format  = translate_format(format) if format.is_a?(Symbol)
      time    = Time.now.at_midnight + value.seconds
      time_of_day = time.strftime(format)
      if options[:omit_minutes_at_full_hour]
        if time_of_day.end_with?('00')
          time_of_day = time_of_day[0...-3]   
        end
      end
      time_of_day
    end
    alias :l :localize

    def translate_format(format)
      I18n.translate("time_of_day.formats.#{format}")
    end

  end

end
