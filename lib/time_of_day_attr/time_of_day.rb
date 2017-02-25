module TimeOfDayAttr
  
  TimeOfDay = Struct.new(:value, :time_format) do
    
    def to_seconds
      begin
        seconds = time.seconds_since_midnight.to_i
        if seconds.zero? && value.starts_with?('24')
          24.hours.to_i
        else
          seconds
        end
      end
    end

    private

    def time
      Time.strptime(value, time_format).change(month: 1, day: 1)
    end

  end
end
