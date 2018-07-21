# Time of day attributes for your Rails model
[![Gem Version](https://badge.fury.io/rb/time_of_day_attr.png)](http://badge.fury.io/rb/time_of_day_attr) [![Code Climate](https://codeclimate.com/github/clemenst/time_of_day_attr.png)](https://codeclimate.com/github/clemenst/time_of_day_attr) [![License](https://img.shields.io/npm/l/express.svg?style=flat)](http://clemenst.mit-license.org)

This ruby gem converts time of day to seconds (since midnight) and back. The value in seconds can be used for calculations and validations.

## Installation

```console
gem install time_of_day_attr
```

## Usage

Define the time of day attributes:
```ruby
class BusinessHour < ActiveRecord::Base
  time_of_day_attr :opening, :closing
end
```

Converts time of day to seconds since midnight when a string was set:
```ruby
business_hour = BusinessHour.new(opening: '9:00', closing: '17:00')
business_hour.opening
 => 32400
business_hour.closing
 => 61200
```

To convert back to time of day:
```ruby
TimeOfDayAttr.l(business_hour.opening)
 => '9:00'
TimeOfDayAttr.l(business_hour.closing)
 => '17:00'
```

You could also omit minutes at full hour:
```ruby
TimeOfDayAttr.l(business_hour.opening, omit_minutes_at_full_hour: true)
 => '9'
```

### Formats

The standard formats for conversion are 'default' and 'hour'.
```yml
en:
  time_of_day:
    formats:
      default: '%k:%M'
      hour: '%k'
```

You can overwrite them or use custom formats:
```yml
en:
  time_of_day:
    formats:
      custom: '%H-%M'
```

Pass the formats you want for conversion:
```ruby
class BusinessHour < ActiveRecord::Base
  time_of_day_attr :opening, formats: [:custom]
end
```

```ruby
business_hour = BusinessHour.new(opening: '09-00')
business_hour.opening
 => 32400
TimeOfDayAttr.l(business_hour.opening, format: :custom)
 => '09-00'
```

### Prepending

If you want to process the converted value in your model, you can use the prepend option:

```ruby
class BusinessHour < ActiveRecord::Base
  attr_reader :tracked_opening, :tracked_closing

  time_of_day_attr :opening
  time_of_day_attr :closing, prepend: true

  def opening=(value)
    @tracked_opening = value
    super(value)
  end

  def closing=(value)
    @tracked_closing = value
    super(value)
  end
end
```

```ruby
business_hour = BusinessHour.new(opening: '9', closing: '9')
business_hour.tracked_opening
=> '9'
business_hour.tracked_closing
=> 32400
```

### time of day field

To get a text field with the converted value:
```erb
<%= form_for(business_hour) do |f| %>
  <%= f.time_of_day_field(:opening) %>
<% end %>
```

## License

[MIT](http://clemenst.mit-license.org)
