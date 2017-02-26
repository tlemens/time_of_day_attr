module TimeOfDayAttr
  module ActiveRecordExt
    extend ActiveSupport::Concern
    
    module ClassMethods
      def time_of_day_attr(*attrs)
        options = attrs.extract_options!
        
        writers = Module.new do
          attrs.each do |attr|
            define_method("#{attr}=") do |value|
              if value.is_a?(String)
                delocalize_args = [value, options[:formats]].compact
                delocalized_value = TimeOfDayAttr.delocalize(*delocalize_args)
                super(delocalized_value)
              else
                super(value)
              end
            end
          end
        end

        if options[:prepend]
          prepend writers
        else
          include writers
        end
      end
    end
  end
end
ActiveSupport.on_load(:active_record) do
  include TimeOfDayAttr::ActiveRecordExt
end
