module TimeOfDayAttr
  module ActiveRecordExt
    extend ActiveSupport::Concern

    module ClassMethods

      def time_of_day_attr *attrs
        options = attrs.extract_options!
        options[:formats] ||= [:default, :hour]
        attrs.each do |attr|
          define_method("#{attr}=") do |value|
            if value.is_a?(String)
              delocalized_values = options[:formats].map { |format| TimeOfDayAttr.delocalize(value, format: format) rescue nil }
              value = delocalized_values.compact.first || send(attr)
            end
            super(value)
          end
        end
      end
    
    end
  end
end
ActiveRecord::Base.send(:include, TimeOfDayAttr::ActiveRecordExt)
