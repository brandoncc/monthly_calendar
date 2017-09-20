# Monthly Calendar Generator

This is a simple library which allows you to create monthly calendars which have
space to write notes.

It allows you to create PDF files like [this one](samples/calendar.pdf).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monthly_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monthly_calendar

## Standard Usage

```ruby
require 'monthly_calendar'

calendar = MonthlyCalendar.new(start_date: "January 2018", pages: 2)
calendar.save("calendar.pdf")
```

This example is the exact code which was used to generate the sample calendar. The `start_date` value can be any string that `Date#parse` can parse, and defaults to `Date.today` if it isn't provided. `pages` is probably self explanatory, but that is how many months will be generated, starting with `start_date`.

## Advanced Usage

The API offers a `#to_s` method which will return the pdf as a string (using [Prawn::Document#render](http://prawnpdf.org/docs/0.11.1/Prawn/Document.html#method-i-render)).

The API also offers a `#stream` method which will yield the pdf as a string to the block you supply.

```ruby
require 'monthly_calendar'

calendar = MonthlyCalendar.new(start_date: "January 2018", pages: 2)
calendar.stream do |calendar_string|
  puts calendar_string
end

# => %PDF-1.3
# => %����
# => 1 0 obj
# => << /Creator <feff0050007200610077006e>
# => /Producer <feff0050007200610077006e>
# ... 
```

These methods will allow you to easily do something like render the value as a response from a web server.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/brandoncc/monthly_calendar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MonthlyCalendar project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/brandoncc/monthly_calendar/blob/master/CODE_OF_CONDUCT.md).
