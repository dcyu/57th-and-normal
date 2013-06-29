
require 'json'
require 'nokogiri'
require "awesome_print"
require 'geocoder'
require 'json'


# Parse CSV for PINs
pin_info = File.read("data/PINS.csv").split("\r").collect{ |row| row.split(',') }

# Create storage for data
output = {}

# Define column names
# TODO: This might be difference between each record
columns = [nil, 'recorded-date', nil, 'type-desc', 'doc-number', 'first-grantor', 'first-grantee']

pin_info.each_with_index do |row, index|
  next if index == 0
  pin = row[0]
  address = row[1]
  city = row[3]
  
  doc = Nokogiri::HTML( File.open("data/#{pin}.html") )
  next if doc.nil?
  
  table = doc.css('table')[7]
  next if table.nil?
  
  tbody = table.css('tbody')[1]
  
  # Storage for PIN
  output[pin] = {}
  
  # Geocode
  s = Geocoder.search("#{address}, #{city}")
  output[pin]['lat'] = s[0].latitude
  output[pin]['lon'] = s[0].longitude
  output[pin]['address'] = s[0].address
  output[pin]['deeds'] = []
  
  tbody.css('tr').each do |tr|
    datum = {}
    tr.css('td').each_with_index do |td, index|
      next if index == 0
      next if index == 2
      
      column = columns[index]
      value = td.css('a').text
      next if value == ''
      
      datum[column] = value
    end
    output[pin]['deeds'].push datum
  end
  
  # To prevent geocoder from making too many requests
  sleep 2
end

puts output.to_json
