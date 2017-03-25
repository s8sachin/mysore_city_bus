require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
require 'csv'

# uri = URI.parse('http://mitra.ksrtc.in/MysoreMBus/rtemap.jsp')
# uri = fetch("http://www.somewebsite.com/hahaha/")
uri = "http://mitra.ksrtc.in/MysoreMBus/rtemap.jsp"
# a=Net::HTTP.get(uri)

bus_details = Nokogiri::HTML(open(uri))
# p "no of buses #{bus_details.css('#country option').count}"
bus_list = []
bus_details.css('#country option').each do |bus|
	bus_list << bus.children.text.gsub( / *\n+ *\t+/, " " )
	p bus.children.text.gsub( / *\n+ *\t+/, " " )
end

route_hash = {}
bus_list.each do |bus|
	bus_stops = []
	uri = "http://mitra.ksrtc.in/MysoreMBus/rtemap.jsp?count="+bus
	out = Nokogiri::HTML(open(uri)).css("td").children.each do |bus_stop|
		bus_stops << bus_stop.text
	end
	route_hash[bus]=bus_stops.reject { |c| c.empty? } 
	p "route --> #{route_hash[bus]}"
end
CSV.open("data.csv","wb") do |csv|
	route_hash.to_a.each do |element|
		csv << element
	end
end


