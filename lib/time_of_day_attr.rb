require 'time_of_day_attr/time_of_day'
require 'time_of_day_attr/seconds'
require 'time_of_day_attr/active_record_ext'
require 'time_of_day_attr/form_builder_ext'

files = Dir[File.join(File.dirname(__FILE__), '../config/locales/*.yml')]
I18n.load_path.concat(files)

module TimeOfDayAttr

  class << self

    def delocalize(value, formats = [:default, :hour])
      formats.each do |format|
        begin
          return TimeOfDay.new(value, time_format(format)).to_seconds
        rescue ArgumentError => e
          if e.message.include?('out of range')
            return nil
          else
            next
          end
        end
      end
    end

    def localize(value, format = :default, options = {})
      return value unless value.respond_to?(:seconds)

      time_of_day = Seconds.new(value, time_format(format)).to_time_of_day

      time_of_day = time_of_day[0...-3] if options[:omit_minutes_at_full_hour] && time_of_day.end_with?('00')

      time_of_day
    end
    alias :l :localize

    private

    def time_format(format)
      I18n.translate("time_of_day.formats.#{format}")
    end

  end
end
