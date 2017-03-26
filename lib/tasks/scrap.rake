require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
require 'csv'

namespace :scrap do
	desc "Scrap data from web and save to CSV"
	task :bus_routes => :environment do
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

		if route_hash.first[0] == "Select"
			route_hash.first[0] = "bus_num" 
			route_hash.first[1] = "route"
		end

		CSV.open("db/master_data/bus_routes.csv","wb") do |csv|
			route_array = route_hash.to_a
			route_array[0] = ["bus_num","route"]
			route_array.each do |element|
				csv << element
			end
		end

	end
end

