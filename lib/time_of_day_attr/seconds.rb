module TimeOfDayAttr
  
  Seconds = Struct.new(:value, :time_format) do
    
    def to_time_of_day
      time_of_day = time.strftime(time_format)
      if 24.hours.to_i == value
        time_of_day.gsub!(' 0', '24')
      end
      time_of_day
    end

    private

    def time
      time = Time.now.beginning_of_year.at_midnight + value.seconds
    end

  end
end
