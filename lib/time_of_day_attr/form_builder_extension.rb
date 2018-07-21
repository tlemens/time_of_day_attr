module TimeOfDayAttr
  module FormBuilderExtension
    extend ActiveSupport::Concern

    def time_of_day_field(method, options = {})
      options[:value] ||= begin
        value = object.public_send(method)
        localize_options = options.extract!(:format, :omit_minutes_at_full_hour)
        TimeOfDayAttr.localize(value, localize_options)
      end
      text_field(method, options)
    end
  end
end
