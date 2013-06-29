
# Script to re-format data so that items are indexed by date

require 'json'
require 'date'
require "awesome_print"

pins = JSON.parse File.read("data/deeds.json")

dates = []

output = {
  '2005' => [],
  '2006' => [],
  '2007' => [],
  '2008' => [],
  '2009' => [],
  '2010q1' => [],
  '2010q2' => [],
  '2010q3' => [],
  '2010q4' => [],
  '2011q1' => [],
  '2011q2' => [],
  '2011q3' => [],
  '2011q4' => [],
  '2012q1' => [],
  '2012q2' => [],
  '2012q3' => [],
  '2012q4' => [],
  '2013q1' => [],
  '2013q2' => [],
  '2013q3' => [],
  '2013q4' => []
}

ranges = {
  '2005' => Date.new(2005, 1, 1)..Date.new(2005, 12, 31),
  '2006' => Date.new(2006, 1, 1)..Date.new(2006, 12, 31),
  '2007' => Date.new(2007, 1, 1)..Date.new(2007, 12, 31),
  '2008' => Date.new(2008, 1, 1)..Date.new(2008, 12, 31),
  '2009' => Date.new(2009, 1, 1)..Date.new(2009, 12, 31),

  '2010q1' => Date.new(2010, 1, 1)..Date.new(2010, 3, 31),
  '2010q2' => Date.new(2010, 4, 1)..Date.new(2010, 6, 30),
  '2010q3' => Date.new(2010, 7, 1)..Date.new(2010, 9, 30),
  '2010q4' => Date.new(2010, 10, 1)..Date.new(2010, 12, 31),

  '2011q1' => Date.new(2011, 1, 1)..Date.new(2011, 3, 31),
  '2011q2' => Date.new(2011, 4, 1)..Date.new(2011, 6, 30),
  '2011q3' => Date.new(2011, 7, 1)..Date.new(2011, 9, 30),
  '2011q4' => Date.new(2011, 10, 1)..Date.new(2011, 12, 31),

  '2012q1' => Date.new(2012, 1, 1)..Date.new(2012, 3, 31),
  '2012q2' => Date.new(2012, 4, 1)..Date.new(2012, 6, 30),
  '2012q3' => Date.new(2012, 7, 1)..Date.new(2012, 9, 30),
  '2012q4' => Date.new(2012, 10, 1)..Date.new(2012, 12, 31),

  '2013q1' => Date.new(2013, 1, 1)..Date.new(2013, 3, 31),
  '2013q2' => Date.new(2013, 4, 1)..Date.new(2013, 6, 30),
  '2013q3' => Date.new(2013, 7, 1)..Date.new(2013, 9, 30),
  '2013q4' => Date.new(2013, 10, 1)..Date.new(2013, 12, 31)
}

# d = Date.new(2005, 1, 1)
# puts d
# puts range2005.cover?(d)

pins.each do |pin, values|
  values['deeds'].each do |deed|
    date = deed['recorded-date'].split('/')
    month = date[0]
    day = date[1]
    year = date[2]
    
    date = Date.new(year.to_i, month.to_i, day.to_i)
    
    # Put date in one of the ranges
    ranges.each do |key, range|
      if range.cover?(date)
        output[key].push pin
        next
      end
    end
    
  end
end

puts output.to_json