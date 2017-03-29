Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "api/v1/get_all_bus_numbers" => "api/v1/searches#get_all_bus_numbers"

  get "api/v1/get_routes_by_bus_num/:bus_num" => "api/v1/searches#get_routes_by_bus_num"
  
  get "api/v1/get_bus_numbers_by_source_and_destination/:source/:destination" => "api/v1/searches#get_bus_numbers_by_source_and_destination"
  # get "api/v1/get_routes_by_bus_num/:bus_num" => "api/v1/searches#get_routes_by_bus_num"
end
