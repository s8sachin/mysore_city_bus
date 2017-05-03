class Api::V1::SearchesController < ApplicationController

  def get_all_bus_numbers
    @bus_numbers = BusRoute.pluck(:bus_num)
    render json: {message: "List of all bus numbers", data: @bus_numbers, status_code: 201}
  end

  def get_all_bus_stops
    @bus_stops = BusRoute.pluck(:route).flatten.uniq
    render json: {message: "List of all bus stops", data: @bus_stops, status_code: 201}
  end

  def get_routes_by_bus_num
    @bus_route = BusRoute.find_by_bus_num(params[:bus_num])
    render json: {message: "List of all bus stops to #{params[:bus_num]}", data: @bus_route, status_code: 201}
  end

  def get_bus_numbers_by_source_and_destination
    @source = params[:source]
    @destination = params[:destination]
    @bus_routes = BusRoute.where("route @> ARRAY[?]::varchar[]", [@source, @destination])
    render json: {message: "List of all bus numbers from #{params[:source] } to #{params[:destination]}", data: @bus_routes.pluck(:bus_num), status_code: 201}
  end

  def list_of_bus_on_bus_stop
    @bus_stop = params[:bus_stop]
    @bus_routes = BusRoute.where("route @> ARRAY[?]::varchar[]", [@bus_stop])
    render json: {message: "List of all bus numbers on #{params[:bus_stop] }", data: @bus_routes.pluck(:bus_num), status_code: 201}
  end

end