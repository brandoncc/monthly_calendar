module UI
  private

  def draw_day_square(week_index, day_index, day_text)
    return unless day_text

    pdf.grid([week_index, day_index], [week_index, day_index]).bounding_box do
      pdf.stroke_bounds

      pdf.rectangle [0, pdf.bounds.height], 15, 15
      pdf.text_box day_text.to_s,
                   at: [0, pdf.bounds.height],
                   height: 15,
                   width: 15,
                   size: 8,
                   align: :center,
                   valign: :center
    end
  end


  def draw_header(month)
    pdf.rectangle [0, pdf.bounds.height + 0.5.in], pdf.bounds.width, 0.5.in
    pdf.text_box month,
                 at: [0, pdf.bounds.height + 0.5.in],
                 width: pdf.bounds.width,
                 height: 0.25.in,
                 align: :center,
                 valign: :center

    weekdays = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    weekdays.each_with_index do |weekday, index|
      width = pdf.bounds.width / 7
      left = width * index
      pdf.rectangle [left, pdf.bounds.height + 0.25.in], width, 0.25.in
      pdf.text_box weekday,
                   at: [left, pdf.bounds.height + 0.23.in],
                   height: 15,
                   width: width,
                   size: 8,
                   align: :center,
                   valign: :center
    end
  end

  def draw_notes(row, nil_cells)
    return if nil_cells[:count].zero?

    pdf.grid([row, nil_cells[:start]],
             [row, nil_cells[:start] + nil_cells[:count] - 1]).bounding_box do
      pdf.stroke_bounds

      pdf.draw_text "Notes",
                     at: [10, pdf.bounds.height - 12],
                     size: 5

      pdf.line [10, 10], [pdf.bounds.width - 10, 10]
      pdf.line [10, 33], [pdf.bounds.width - 10, 33]
      pdf.line [10, 56], [pdf.bounds.width - 10, 56]
      pdf.line [10, 79], [pdf.bounds.width - 10, 79]
    end
  end
end
