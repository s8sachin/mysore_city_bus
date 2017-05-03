require 'rails_helper'
require 'json'

RSpec.describe Api::V1::SearchesController, type: :controller do

  let(:route1){FactoryGirl.create(:bus_route)}
  let(:route2){FactoryGirl.create(:bus_route, bus_num: "10A Up", route: ["JP Nagar Last Stop", "Police Booth", "Kavitha Bakery", "Gobli Mara", "Shanidevara Temple", "Maharshi Public School", "Ganesh Temple", "Sterling Talkies", "Mahalakshmi Stores", "Ramalingeshwara Temple", "Chamundipuram", "Five Light Circle", "Ashoka Circle", "RTO", "Ramaswamy Circle", "Maharani College", "Railway Station", "Dasappa Circle", "Akashavani", "Vonti Koppal Temple", "ESI Hospital", "PK Sanitorium", "Metagalli Police Station", "Sanjeevini Circle", "Basavanagudi", "State Bank of India", "Surya Bakery", "Abhishek Circle", "Made Gowda Circle", "CITB Choultry", "Mayura Circle", "Cauvery Circle", "Sankranthi Circle", "Kitturu Rani Chennamma Circle", "Laxmikantha Nagar", "Ganesh Temple", "Bharath Cancer Hospital", "Shobha Gate", "Infosys "])}
  let(:route3){FactoryGirl.create(:bus_route, bus_num: "10A Down", route: ["LnT", "Infosys", "Shobha Gate", "Bharath Cancer Hospital", "Ganesh Temple", "Laxmikantha Nagar", "Kitturu Rani Chennamma Circle", "Sankranthi Circle", "Cauvery Circle", "Mayura Circle", "CITB Choultry", "Made Gowda Circle", "Abhishek Circle", "Surya Bakery", "State Bank of India", "Basavanagudi", "Sanjeevini Circle", "Metagalli Police Station", "PK Sanitorium", "ESI Hospital", "Vonti Koppal Temple", "Akashavani", "Dasappa Circle", "Railway Station", "Maharani College", "Ramaswamy Circle", "RTO", "Ashoka Circle", "Five Light Circle", "Chamundipuram", "St Marys Convent", "Karumariyamma Temple", "Sewage Farm", "Mahalakshmi Stores", "Sterling Talkies", "Ganesh Temple", "Maharshi Public School", "Shanidevara Temple", "Gobli Mara", "Kavitha Bakery", "Police Booth "])}

  describe "get all bus numbers" do
    context "positive case" do 
      it "should get all bus numbers from db" do 
        route1
        route2
        route3
        get :get_all_bus_numbers
        expect(JSON.parse(response.body)["message"]).to eq("List of all bus numbers")
        expect(JSON.parse(response.body)["status_code"]).to eq(201)
        expect(JSON.parse(response.body)["data"].count).to eq(3)
      end
    end
    context "negative case" do 
      it "should raise exception when no proper data is present" do 
        get :get_all_bus_numbers
        expect(JSON.parse(response.body)["message"]).to eq("Data not found. Try again.")
        expect(JSON.parse(response.body)["status_code"]).to eq(412)
      end
    end
  end

  describe "get all bus stops" do
    context "positive case" do 
      it "should get all bus stops from db" do 
        route1
        route2
        route3
        get :get_all_bus_stops
        expect(JSON.parse(response.body)["message"]).to eq("List of all bus stops")
        expect(JSON.parse(response.body)["status_code"]).to eq(201)
        expect(JSON.parse(response.body)["data"].count).to eq(63)
      end
    end
    context "negative case" do 
      it "hould raise exception when no proper data is present" do 
        get :get_all_bus_stops
        expect(JSON.parse(response.body)["message"]).to eq("Data not found. Try again.")
        expect(JSON.parse(response.body)["status_code"]).to eq(412)
      end
    end
  end

  describe "get routes bus number" do
    context "positive case" do 
      it "should get all routes from a bus number" do 
        route1
        route2
        route3
        get :get_routes_by_bus_num, {:bus_num => route1.bus_num}
        expect(JSON.parse(response.body)["message"]).to eq("List of all bus stops to #{route1.bus_num}")
        expect(JSON.parse(response.body)["data"]["bus_num"]).to eq(route1.bus_num)
        expect(JSON.parse(response.body)["data"]["route"]).to eq(route1.route)
        expect(JSON.parse(response.body)["status_code"]).to eq(201)
      end
    end
    context "negative case" do
      it "should  raise exception when proper params are not given" do 
        get :get_routes_by_bus_num
        expect(JSON.parse(response.body)["message"]).to eq("Data not found. Try again with proper request parameter 'bus_num'.")
        expect(JSON.parse(response.body)["status_code"]).to eq(412)
      end
    end
  end

  describe "get bus numbers by source and destination" do
    context "positive case" do 
      it "should get bus numbers when source and destiniton is given" do 
        route1
        route2
        route3
        @source = " Palace Bus Stop "
        @destination = " Chamundi Hill "
        get :get_bus_numbers_by_source_and_destination,{ :source => @source, :destination => @destination}
        expect(JSON.parse(response.body)["message"]).to eq("List of all bus numbers from  Palace Bus Stop  to  Chamundi Hill ")
        expect(JSON.parse(response.body)["data"]).to eq([route1.bus_num])
        expect(JSON.parse(response.body)["status_code"]).to eq(201)
      end
    end
    context "negative case" do
      it "should raise exception when proper params are not given" do 
        route1
        route2
        route3
        @source = " Palace Bus Stop "
        @destination = " Chamundi Hill "
        get :get_bus_numbers_by_source_and_destination
        expect(JSON.parse(response.body)["message"]).to eq("Data not found. Try again with proper request parameters 'source' and 'destination'.")
        expect(JSON.parse(response.body)["status_code"]).to eq(412)
      end
    end
  end

  describe "list of bus on bus stop" do
    context "positive case" do 
      it "should get list of bus on given bus stop" do 
        route1
        route2
        route3
        @bus_stop = "LnT"
        get :list_of_bus_on_bus_stop, {:bus_stop => @bus_stop}
        expect(JSON.parse(response.body)["message"]).to eq("List of all bus numbers on LnT")
        expect(JSON.parse(response.body)["data"]).to eq([route3.bus_num])
        expect(JSON.parse(response.body)["status_code"]).to eq(201)
      end
    end
    context "negative case" do
      it "should raise exception when proper bus stop param is not given" do 
        @bus_stop = " Palace Bus Stop "
        get :list_of_bus_on_bus_stop, :bus_stop => @bus_stop
        expect(JSON.parse(response.body)["message"]).to eq("Data not found. Try again with proper request parameter 'bus_stop'.")
        expect(JSON.parse(response.body)["status_code"]).to eq(412)
      end
    end
  end

end
