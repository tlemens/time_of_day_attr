module TimeOfDayAttr
  module TimeFormat
    def self.translate_format(format)
      translate = format.is_a?(Symbol)
      translate ? I18n.translate("time_of_day.formats.#{format}") : format
    end
  end
end
