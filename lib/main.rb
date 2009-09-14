#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================

require 'yesradio'
require 'pp'

# get the list of radio stations
stations_sc = Yesradio::StationsSearchCriteria.new
stations_sc.match = "Rock"
stations = Yesradio::WebService.search_stations stations
p stations


# get the nearest intersection
intersection = Yesradio::WebService.find_nearest_intersection 40.7574053333333, -73.9734773333333
puts intersection.street_1 #=> Park Ave
puts intersection.street_2 #=> E 51st St

# get wikipedia articles by lat / long
articles_nearby = Yesradio::WebService.find_nearby_wikipedia :lat => 43.900120387, :long => -78.882869834
p articles_nearby

# get wikipedia articles by bounding box
articles_nearby = Yesradio::WebService.find_bounding_box_wikipedia :north => 43.900120387, :east => -78.882869834, :south => 43.82, :west => 79.0
p articles_nearby

# get list of places near by longitude/longitude location
places_nearby = Yesradio::WebService.find_nearby_place_name 43.900120387, -78.882869834
p places_nearby

# get timezone for longitude/longitude location
timezone = Yesradio::WebService.timezone 43.900120387, -78.882869834
p timezone

# get country code for longitude/longitude location
country_code = Yesradio::WebService.country_code 43.900120387, -78.882869834
p country_code

# get country sub-division info for longitude/longitude location
country_subdivision = Yesradio::WebService.country_subdivision 43.900120387, -78.882869834
p country_subdivision

# get postal codes for a given location
postal_code_sc = Yesradio::PostalCodeSearchCriteria.new
postal_code_sc.place_name = "Oshawa"
postal_codes = Yesradio::WebService.postal_code_search postal_code_sc
p postal_codes

# get nearby postal codes for a place name
postal_code_sc = Yesradio::PostalCodeSearchCriteria.new
postal_code_sc.place_name = "Oshawa"
postal_codes_nearby = Yesradio::WebService.find_nearby_postal_codes postal_code_sc
p postal_codes_nearby

