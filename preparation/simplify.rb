#!/usr/bin/env ruby
require 'csv'

MONTHS={
  "January" => 1,
  "February" => 2,
  "March" => 3,
  "April" => 4,
  "May" => 5,
  "June" => 6,
  "July" => 7,
  "August" => 8,
  "September" => 9,
  "October" => 10,
  "November" => 11,
  "December" => 12
}

months = MONTHS.keys.join("|")

DESTINATIONS = {
   "Port Phillip" => ["Port Phillip", "New South Wales"],
   "Moreton Bay" => ["Moreton Bay", "Queensland"],
   "Maria Island" => ["Maria Island", "Tasmania"],
   "New South Wales" => ["", "New South Wales"],
   "Van Diemen" => ["", "Van Diemen's Land"],
   "Norfolk Island" => ["", "Norfolk Island"],
   "VDI" => ["", "Van Diemen's Land"],
   "V.D.I" => ["", "Van Diemen's Land"],
   "Gibraltar" => ["", "Gibraltrar"],
   "Western Australia" => ["", "Western Australia"],
}


INPUT_FILE="cleaned/cleaned.csv"

CSV.foreach(INPUT_FILE, :encoding => "ISO-8859-1", :headers => :first_row) do |row|
  ### date simplification
  departure_date = row["Date of Departure"]
  year_matches = /(17|18)\d{2}/.match(departure_date)
  simple_date = ""
  year = ""
  unless year_matches.nil?
    year = year_matches[0]
    month_matches = /#{months}/.match(departure_date)
    unless month_matches.nil?
      month_number =  MONTHS[month_matches[0]]
      simple_date = "%s-%02i" % [year, month_number]
    end
  end
  #puts simple_date

  ### vessel simplification
  vessel = row["Vessel"].to_s
  simple_vessel = vessel.to_s.gsub(".", "").gsub(/\[.*\]/, "").strip.sub(/[^a-zA-Z]*$/, "").sub("(Ship)", "").sub(/\(Ship$/, "").sub(/ Sentence details.*$/, "")
  # remove extra spaces in lists of ships
  simple_vessels = []
  simple_vessel.split(";").each do |item|
    simple_vessels << item.strip
  end
  simple_vessel = simple_vessels.join("|")
  if simple_vessel.start_with? "Lord Lynedoch"
    simple_vessel = "Lord Lynedoch"
  end

  ### destination simplication
  destination = row["Place of Arrival"]
  simple_destinations = []
  DESTINATIONS.each do |k,v|
    if destination.downcase.include? k.downcase
      simple_destinations << v
    end
  end
  simple_destination = simple_destinations[0] #.join(",").to_s

  #if simple_destination.length == 0
  #  puts destination
  #end

  puts [simple_date,simple_vessel, simple_destination[0], simple_destination[1]].to_csv

end
