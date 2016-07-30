#!/usr/bin/env ruby
require 'csv'


INPUT_FILE="input/slqBritishConvictRegisters201605.csv"

CSV.foreach(INPUT_FILE, :encoding => "ISO-8859-1", :headers => :first_row) do |row|
  # iterate each piece of data
  output_row = {}
  row.each do |cell_name, cell_value|
    cell_name_cleaned = cell_name.to_s.strip
    if (cell_name_cleaned.length > 0)
      output_row[cell_name_cleaned] = cell_value
    end
  end
  row.each do |cell_name, cell_value|
    # check if it begins with one of the header names
    row.headers.each do |header_name|
      header_name_cleaned = header_name.to_s.strip
      if header_name_cleaned.length > 0 and cell_value.to_s.start_with?(header_name_cleaned)
        original = output_row[header_name_cleaned]

        cell_value_trimmed = cell_value.sub(/#{header_name_cleaned}:?\s*/, "")
        output_row[header_name_cleaned] = cell_value_trimmed
        $stderr.puts "Changing (%s) from [%s] to [%s]" % [header_name_cleaned, original, cell_value_trimmed]
      end
    end
  end
  puts output_row.values.to_csv

end
