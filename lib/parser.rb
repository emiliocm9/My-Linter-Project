require 'nokogiri'

file = File.open('../bin/index.html', 'rb')
page = Nokogiri::HTML(file.read)
puts page.css('h1')[0].name