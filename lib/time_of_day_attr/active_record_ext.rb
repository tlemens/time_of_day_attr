module TimeOfDayAttr
  module ActiveRecordExt
    extend ActiveSupport::Concern

    module ClassMethods

      def time_of_day_attr(*attrs)
        options = attrs.extract_options!
        options[:formats] ||= [:default, :hour]
        attrs.each do |attr|
          define_method("#{attr}=") do |value|
            if value.is_a?(String)
              delocalized_values = options[:formats].map do |format|
                begin
                  TimeOfDayAttr.delocalize(value, format: format)
                rescue ArgumentError
                  nil
                end
              end
              delocalized_value = delocalized_values.compact.first
              raise(ArgumentError, "invalid time of day #{value} for formats #{options[:formats].join(', ')}") unless delocalized_value
            end
            super(delocalized_value || value)
          end
        end
      end
    
    end
  end
end
ActiveRecord::Base.send(:include, TimeOfDayAttr::ActiveRecordExt)
