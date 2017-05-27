require 'rubygems'
require 'tabula'
require 'pry'
require 'pry'
require 'json'
require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
require 'csv'
require 'nokogiri'
require 'open-uri'

# pdf_file_path = "/home/qwinix/Desktop/routeDetails.jsp?value=10A"
outfilename = "time_details.csv"

out = open(outfilename, 'w')
# out = []

uri = "http://mitra.ksrtc.in/MysoreMBus/rtedtls.jsp"
bus_details = Nokogiri::HTML(open(uri)).css("div>div>b a").children.map{|a| a.text.gsub(/[^0-9A-Za-z\-\s]/, '')}
begin
	bus_details.each do |bus_detail|
		sub_uri = uri+"?value="+bus_detail
		bus_numbers = Nokogiri::HTML(open(sub_uri)).css("td tr a").children.map{|p| p.text.gsub( / *\n+ *\t+/, " " ).strip}.reject(&:empty?)
		bus_numbers.each do |bus_number|
			pdf_base_uri = "http://mitra.ksrtc.in/MysoreMBus/routeDetails.jsp"
			bus_number = bus_number.gsub(" ", "")
			pdf_uri = pdf_base_uri+"?value="+bus_number
			`wget -P public/ #{pdf_uri}`
			pdf_name = "public/routeDetails.jsp?value="+bus_number
			extractor = Tabula::Extraction::ObjectExtractor.new(pdf_name, :all )
			extractor.extract.each do |pdf_page|
				unless pdf_page.texts.map{|a| a.text}.join("").include?("Records Not Found!!!")
					if pdf_page.texts.map{|a| a.text}.join("").include?("Direction:UP")
						@bus = bus_number+" Up" 
					elsif pdf_page.texts.map{|a| a.text}.join("").include?("Direction:DOWN")
						@bus = bus_number+" Down"
					end
					pdf_page.spreadsheets.each do |spreadsheet|
						out << spreadsheet.to_csv.gsub("\r", ' ').gsub(/\n+/, ", #{@bus}\n")
					end
				end
			end
			puts "\n\n===========================Extracted details of #{bus_number}===========================\n\n"
		end
	end
rescue
	"#################################### Something went wrong ####################################"
end
out.close