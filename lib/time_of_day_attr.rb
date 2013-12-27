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

  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def time_of_day_attr *attrs
      options = attrs.extract_options!
      formats = options[:formats] || [:default, :hour]
      attrs.each do |attr|
        define_method("#{attr}=") do |value|
          if value.is_a?(String)
            delocalized_values = formats.map { |format| TimeOfDayAttr.delocalize(value, format: format) rescue nil }.compact
            value = delocalized_values.first || send(attr)
          end
          super(value)
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, TimeOfDayAttr
