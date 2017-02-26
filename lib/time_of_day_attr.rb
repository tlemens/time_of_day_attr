require 'time_of_day_attr/time_of_day'
require 'time_of_day_attr/seconds'
require 'time_of_day_attr/active_record_ext'
require 'time_of_day_attr/form_builder_ext'

formats = Dir[File.join(File.dirname(__FILE__), '../config/locales/*.yml')]
I18n.load_path.concat(formats)

module TimeOfDayAttr

  class << self

    def delocalize(value, formats = [:default, :hour])
      time_of_day = TimeOfDay.new(value)
      formats.each do |format|
        begin
          return time_of_day.to_seconds(time_format(format))
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

      time_of_day = Seconds.new(value).to_time_of_day(time_format(format))

      omit_minutes = options[:omit_minutes_at_full_hour] && time_of_day.end_with?('00')

      omit_minutes ? time_of_day[0...-3] : time_of_day
    end
    alias :l :localize

    private

    def time_format(format)
      translate = format.is_a?(Symbol)
      
      translate ? I18n.translate("time_of_day.formats.#{format}") : format
    end

  end
end
