# Monthly Calendar Generator

This is a simple library which allows you to create monthly calendars which have
space to write notes.

It allows you to create PDF files like [this one](samples/calendar.pdf).

## Standard Usage

```ruby
require 'monthly_calendar'

calendar = MonthlyCalendar.new(start_date: "January 2018", pages: 2)
calendar.save("calendar.pdf")
```

This example is the exact code which was used to generate the sample calendar. The `start_date` value can be any string that `Date#parse` can parse, and defaults to `Date.today` if it isn't provided. `pages` is probably self explanatory, but that is how many months will be generated, starting with `start_date`.

## Advanced Usage

The API also offers a `#stream` method which will yield the pdf as a string (using [Prawn::Document#render](http://prawnpdf.org/docs/0.11.1/Prawn/Document.html#method-i-render)) to the block you supply.

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

This usage will allow you to easily do something like render the value as a response from a web server.

## Bugs, Improvements, Etc

If you find a bug or have an idea for an improvement, please open an issue. If you would like to take a stab at fixing any bugs or adding a feature, feel free to open a pull request.

## Tests

There are not currently any tests, but eventually there should be.