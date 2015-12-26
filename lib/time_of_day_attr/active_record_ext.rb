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
                rescue ArgumentError => e
                  if 'argument out of range' == e.message
                    super(nil)
                    return
                  end
                  nil
                end
              end
              delocalized_value = delocalized_values.compact.first
              super(delocalized_value)
            else
              super(value)
            end
          end
        end
      end
    
    end
  end
end
ActiveRecord::Base.send(:include, TimeOfDayAttr::ActiveRecordExt)
