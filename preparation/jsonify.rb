#!/usr/bin/env ruby
require 'csv'
require 'json'

PATH_MAP = {
  "Queensland" => "M145,85 Q80,180 45,300 T210,560 Q300,620 540,640 T870,620 Q920,590 875,527",
  "New South Wales" => "M145,85 Q80,180 45,300 T210,560 Q300,620 540,640 T870,620 Q920,590 865,557",
  "Norfolk Island" => "M145,85 Q80,180 45,300 T210,560 Q300,620 540,640 T870,620 Q920,590 952,516",
  "Van Diemen's Land" => "M145,85 Q80,180 45,300 T210,560 Q300,620 540,640 T850,590",
  "Tasmania" => "M145,85 Q80,180 45,300 T210,560 Q300,620 540,640 T850,590",
  "Western Australia" => "M145,85 Q80,180 45,300 T210,560 T690,536"
}


def jitter(path)
  parts = []
  path.split(" ").each do |section|
    left, right_num = section.split(",")

    matches = /([A-Z]?)(\d+)/.match(left)
    letter = matches[1]
    left_num = matches[2]

    parts << "%s%i,%i" % [letter, left_num.to_i + rand(-5..5), right_num.to_i + rand(-5..5)]
  end
  result = parts.join(" ")
  return result
end


COLOUR_MAP = [
'#000080',
'#0000ff',
'#0080ff',
'#00ffff',
'#80ff80',
'#ffff00',
'#ff8000',
'#ff0000',
'#800000',
'#0000ff',
'#007f00',
'#ff0000'
]

MONTH_MAP = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
]


INPUT_FILE="output1/output.txt"

out_all = []

CSV.foreach(INPUT_FILE) do |row|
  year = row[0].split("-")[0].to_i
  month = row[0].split("-")[1].to_i

  delay_before_animate = month + ((year-1787)*12)


  out_hash = {
    "p" => jitter(PATH_MAP[row[3]]),
    "d" => delay_before_animate,
    "c" => COLOUR_MAP[month-1],
    "t" => Math.log(row[4].strip.to_i) + 1,
    "vessel" => row[1],
    "date" => "%s %s" % [MONTH_MAP[month.to_i-1], year],
    "convicts" => row[4].strip.to_i,
    "dest" => row[3]
  }

  out_all << out_hash
end
print "var ships = "
print out_all.to_json
puts ";"
