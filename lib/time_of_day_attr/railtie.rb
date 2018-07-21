module TimeOfDayAttr
  class Railtie < ::Rails::Railtie
    initializer 'time_of_day_attr.initialize' do
      ActiveSupport.on_load(:active_record) do
        include TimeOfDayAttr::ActiveRecordExtension
      end
      ActiveSupport.on_load(:action_view) do
        ActionView::Helpers::FormBuilder.send(:include, TimeOfDayAttr::FormBuilderExtension)
      end
    end
  end
end
