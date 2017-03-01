require 'action_view'

module TimeOfDayAttr
  module FormBuilderExt
    extend ActiveSupport::Concern

    def time_of_day_field(method, options = {})
      options[:value] ||= begin
        value = object.public_send(method)
        TimeOfDayAttr.localize(value, options.extract!(:format, :omit_minutes_at_full_hour))
      end
      text_field(method, options)
    end
  end
end
ActiveSupport.on_load :action_view do
  ActionView::Helpers::FormBuilder.send(:include, TimeOfDayAttr::FormBuilderExt)
end
