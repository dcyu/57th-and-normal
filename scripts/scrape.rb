
require 'json'
require 'nokogiri'
require "awesome_print"


# Parse CSV for PINs
pin_info = File.read("PINS.csv").split("\r").collect{ |row| row.split(',') }

# Create storage for data
output = {}

# Define column names
# TODO: This might be difference between each record
columns = [nil, 'recorded-date', nil, 'type-desc', 'doc-number', 'first-grantor', 'first-grantee']

pin_info.each_with_index do |row, index|
  next if index == 0
  pin = row[0]
  
  doc = Nokogiri::HTML( File.open("#{pin}.html") )
  next if doc.nil?
  
  table = doc.css('table')[7]
  next if table.nil?
  
  tbody = table.css('tbody')[1]
  
  output[pin] = []
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
    output[pin].push datum
  end
  
end
ap output
