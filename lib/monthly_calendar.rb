require "monthly_calendar/version"
require "date"
require "prawn"
require "prawn/measurement_extensions"
require_relative "./ui"

class MonthlyCalendar
  include UI

  attr_reader :pdf

  def initialize(options = {})
    @start_date = (options[:start_date] && Date.parse(options[:start_date])) ||
                  Date.today
    @pages_count = options[:pages] || 1

    @pdf = Prawn::Document.new(page_layout: :landscape, top_margin: 1.in, skip_page_creation: true)
    create
  end

  def save(file_name = "calendar.pdf")
    pdf.render_file File.expand_path(file_name)
  end

  def stream
    yield(to_s)
  end

  def to_s
    pdf.render
  end

  private

  def create
    calendar_contents.each do |(month, weeks)|
      pdf.start_new_page

      days_in_month = weeks.flatten.compact.max
      first_day_of_week = weeks[0].index(1)

      weeks_count = ((days_in_month + first_day_of_week) / 7.0).ceil

      pdf.define_grid(rows: weeks_count, columns: 7)

      draw_header(month)

      weeks.each_with_index do |week, week_index|
        draw_notes(week_index,
                   find_nil_cells(week),
                   weeks_count == 6 ? :close : :far)

        week.each_with_index do |day, day_index|
          draw_day_square(week_index, day_index, day)
        end
      end

      # The last thing drawn on each page isn't rendered for some reason so this
      # just "flushes the queue" (causes the last thing previous to be drawn)
      pdf.stroke
    end
  end

  def calendar_contents
    months = []

    current_month = @start_date

    @pages_count.times do |page_index|
      month_text = current_month.strftime("%B %Y")

      days_in_month = Date.new(current_month.year, current_month.month, -1).mday
      first_day_of_week = Date.new(current_month.year, current_month.month, 1).wday

      weeks_count = ((days_in_month + first_day_of_week) / 7.0).ceil

      days = []
      days << [] until days.count == weeks_count

      first_day_of_week.times do
        days[0] << nil
      end

      days_in_month.times do |day|
        week = (day + first_day_of_week) / 7
        days[week] << day + 1
      end

      days[4] << nil until days[4].count == 7

      unless days[5].nil?
        days[5] << nil until days[5].count == 7
      end

      months << [month_text, days]
      current_month = current_month.next_month
    end

    months
  end

  def find_nil_cells(week)
    { start: week.index(nil), count: week.count(nil) }
  end
end
