module TimeOfDayAttr
  module FormBuilderExt
    extend ActiveSupport::Concern

    def time_of_day_field(method, options = {})
      options[:value] ||= begin
        value = object.public_send(method)
        format = options.delete(:format) || :default
        TimeOfDayAttr.localize(value, format, options.extract!(:omit_minutes_at_full_hour))
      end
      text_field(method, options)
    end
  end
end
ActiveSupport.on_load :action_view do
  ActionView::Helpers::FormBuilder.send(:include, TimeOfDayAttr::FormBuilderExt)
end
