require 'csv'

namespace :import do

  desc "Import all Bus and is Routes"
  task :bus_routes => :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('bus_routes') if BusRoute.count == 0
    path = File.join(Rails.root, "db", "master_data", "bus_routes.csv")
    csv_table = CSV.table(path, {:headers => true, :converters => nil, :header_converters => :symbol})
    headers = csv_table.headers
    csv_table.each_with_index do|row, index|
      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }
      next if row[:bus_num].blank?
      bus_route = BusRoute.find_by(:bus_num => row[:bus_num])
      if bus_route.present?
        p "Bus with num #{bus_route.bus_num} is ALREADY PRESENT"
      else
        bus_route = BusRoute.new(:bus_num => row[:bus_num], :route => JSON.parse(row[:route]).map(&:strip))
        if bus_route.valid? && bus_route.save
          p "Bus Route with bus number #{bus_route.bus_num} is CREATED"
        else
          p "Error! #{bus_route.errors.full_messages.to_sentence}"
        end
      end
    end
  end
  desc "Import all Bus and is Routes"
  task :time_details => :environment do
    # ActiveRecord::Base.connection.reset_pk_sequence!('time_details') if BusRoute.count == 0
    path = File.join(Rails.root, "db", "master_data", "time_details.csv")
    csv_table = CSV.table(path, {:headers => true, :converters => nil, :header_converters => :symbol, :col_sep => "@", :quote_char => "\x00"})
    binding.pry
    headers = csv_table.headers
    # CSV.foreach(path, :col_sep => "@", :quote_char => "\x00") do|row, index|
    csv_table.each_with_index do|row, index|
      row.headers.each{ |cell| row[cell] = row[cell].to_s.strip }
      # exit
    end
  end

end