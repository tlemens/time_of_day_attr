module TimeOfDayAttr
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods
      def time_of_day_attr(*attrs)
        options = attrs.extract_options!

        writers = AttrWriterModule.new(attrs, options)

        if options[:prepend]
          prepend writers
        else
          include writers
        end
      end
    end
  end

  module AttrWriterModule
    # rubocop:disable Metrics/MethodLength
    def self.new(attrs, options)
      Module.new do
        attrs.each do |attr|
          define_method("#{attr}=") do |value|
            if value.is_a?(String)
              delocalized_value = TimeOfDayAttr.delocalize(value, options)
              super(delocalized_value)
            else
              super(value)
            end
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
