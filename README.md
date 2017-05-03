<a href="https://codeclimate.com/github/s8sachin/mysore_city_bus"><img src="https://codeclimate.com/github/s8sachin/mysore_city_bus/badges/gpa.svg" /></a>
<a href="https://codeclimate.com/github/s8sachin/mysore_city_bus/coverage"><img src="https://codeclimate.com/github/s8sachin/mysore_city_bus/badges/coverage.svg" /></a>
<a href="https://codeclimate.com/github/s8sachin/mysore_city_bus"><img src="https://codeclimate.com/github/s8sachin/mysore_city_bus/badges/issue_count.svg" /></a>
[![Stories in Ready](https://badge.waffle.io/s8sachin/mysore_city_bus.png?label=ready&title=Ready)](https://waffle.io/s8sachin/mysore_city_bus)
# README

This is just an open source API repo for <b>Mysore City Bus</b>. Created using webscrapping techniques.
Original link to <a href="http://mitra.ksrtc.in/MysoreMBus/index_e.jsp">KSRTC ITS</a>
We have just extracted data and saved in different format to serve our purpose.


The web scrapping logic used can be found in `/lib/tasks` directory containing `rake` files.

## Usage: ##

1. Clone the repo using `git clone https://github.com/s8sachin/mysore_city_bus.git` or `git clone git@github.com:s8sachin/mysore_city_bus.git`

2. Setup your `database.yml`

3. `bundle install`

4. `bundle exec rake db:create db:migrate`

5. Initially the bus routes details are stored in `/db/master_data/bus_routes.csv`. You can directly import them by running `bundle exec rake import:bus_routes`

6. Or you can scrap data from web by running `bundle exec rake scrap:bus_routes`, This creates CSV file in `/db/master_data`. Then run  'bundle exec rake import:bus_routes'

7. Check routes.rb for list of API paths. 

## Heroku API ##

This app is deployed on Heroku and the api can be used from heroku. 

### Examples (Heroku) ###

1. Get list of all bus numbers API Path `/get_all_bus_numbers` 

eg: https://mcb-api.herokuapp.com/get_all_bus_numbers

2. Get list of all bus stops API Path `/get_all_bus_stops`

eg: https://mcb-api.herokuapp.com/get_all_bus_stops

3. Get list of routes from a bus number `/get_routes_by_bus_num?bus_num=`

request params : "bus_num"

eg: https://mcb-api.herokuapp.com/get_routes_by_bus_num?bus_num=119%20Up

4. Get list of bus numbers by "source" and "destination" `/get_bus_numbers_by_source_and_destination?source=&destination=` 

request params : "source" , "destination"

eg: https://mcb-api.herokuapp.com/get_bus_numbers_by_source_and_destination?source=Dasappa%20Circle&destination=Infosys

5. Get list of buses going on a perticular "bus stop" `/list_of_bus_on_bus_stop?bus_stop=` 

request params : "bus_stop"

eg: http://mcb-api.herokuapp.com/list_of_bus_on_bus_stop?bus_stop=Dasappa%20Circle


#### Fork and help us improve ### :)
