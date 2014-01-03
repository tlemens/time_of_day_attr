module TimeOfDayAttr
  module FormBuilderExt
    extend ActiveSupport::Concern

    def time_of_day_field(method, options = {})
      unless options[:value]
        value = object.send(method)
        options[:value] = TimeOfDayAttr.localize(value, options.extract!(:format, :omit_minutes_at_full_hour))
      end
      text_field(method, options)
    end

  end
end
ActionView::Helpers::FormBuilder.send(:include, TimeOfDayAttr::FormBuilderExt)
