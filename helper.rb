module Helper
  def draw_matrix_as_table(rows)
    html = "<table class=\"stats-table\">"
    rows.each_with_index do |row, row_num|
      if row_num == 0
        html << "<head>"
        html << draw_table_row(row, cell_tag: "th")
        html << "</head><body>"
      else
        html << draw_table_row(row)
      end
      html << "</body>" if row_num == 0
    end
    html << "</table>"
  end

  def draw_table_row(row, cell_tag: "td")
    html = "<tr>"
    row.each { |col| html << "<#{cell_tag}>#{col}</#{cell_tag}>" }
    html << "</tr>"
    html
  end
end
