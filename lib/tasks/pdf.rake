require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
require 'csv'
namespace :scrap do
  task :pdf => :environment do
    @bus_numbers = BusRoute.pluck(:bus_num)
    uri = "http://mitra.ksrtc.in/MysoreMBus/rtedtls.jsp"
      binding.pry
    bus_details = Nokogiri::HTML(open(uri)).css("div>div>b a").children.map{|a| a.text.gsub(/[^0-9A-Za-z\-\s]/, '')}
    bus_details.each do |bus_detail|
      sub_uri = uri+"?value="+bus_detail
      bus_numbers = Nokogiri::HTML(open(sub_uri)).css("tr a").children.map{|p| p.text.gsub( / *\n+ *\t+/, " " ).strip}.reject(&:empty?)
      # bus_numbers.each do |bus_number|
      #   pdf_base_uri = "http://mitra.ksrtc.in/MysoreMBus/routeDetails.jsp"
      #   pdf_uri = pdf_base_uri+"?value="+bus_number
      #   FileUtils.rm_rf("public/temp_pdf")
      #   FileUtils.mkdir("public/temp_pdf")
      #   temp_pdf = Rails.root.join('public/temp_pdf/')
      #   `wget -P public/temp_pdf/ #{pdf_uri}`
      #   pdf_name = "public/temp_pdf/routeDetails.jsp?value="+bus_number
      #   reader = PDF::Reader::Turtletext.new(Rails.root.join(pdf_name))
      #   options = { :y_precision => 5 }
      #   reader_with_options = PDF::Reader::Turtletext.new(Rails.root.join(pdf_name),options)
      #   textangle = reader.bounding_box do
      #     page 1
      #     # below /electricity/i
      #     # above 10
      #     # right_of 240.0
      #     # left_of "Total ($)"
      #   end
      #   binding.pry
        # exit
      # end
    end
  end
end
