# time_of_day_attr
[![Gem Version](https://badge.fury.io/rb/time_of_day_attr.png)](http://badge.fury.io/rb/time_of_day_attr) [![Code Climate](https://codeclimate.com/github/clemenst/time_of_day_attr.png)](https://codeclimate.com/github/clemenst/time_of_day_attr)

Convert time of day to seconds since midnight and back.

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

The standard formats for conversation are 'default' and 'hour'.
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

Pass the formats you want for conversation:
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

### time of day field

To get a text field with the converted value:
```erb
<%= form_for(business_hour) do |f| %>
  <%= f.time_of_day_field(:opening) %>
<% end %>
```

## License

This project uses MIT-LICENSE

Copyright 2013 by Clemens Teichmann

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
