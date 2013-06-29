require 'json'

str = File.read("deeds.txt")
str.gsub!(/\[.*\]/, '')

data = eval(str)

puts data.to_json