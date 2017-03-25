require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
require 'csv'

uri = "http://mitra.ksrtc.in/MysoreMBus/rtemap.jsp"
bus_details = Nokogiri::HTML(open(uri))
bus_list = {}
route_hash = {}
bus_details.css('#country option').each do |bus|
	bus_value = bus.attr("value")
	bus_list[bus_value] = bus.children.text.gsub( / *\n+ *\t+/, " " )
	bus_stops = []
	uri = "http://mitra.ksrtc.in/MysoreMBus/rtemap.jsp?count="+bus_value
	out = Nokogiri::HTML(open(uri)).css("td").children.each do |bus_stop|
		bus_stops << bus_stop.text
	end
	route_hash[bus_list[bus_value]]=bus_stops.reject { |c| c.empty? } 
	p "route --> #{route_hash[bus_list[bus_value]]}"
end

CSV.open("data.csv","wb") do |csv|
	route_hash.to_a.each do |element|
		csv << element
	end
end


