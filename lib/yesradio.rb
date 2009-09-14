#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================

require 'cgi'
require 'net/http'
require 'rexml/document'

require 'station'
require 'stations_search_criteria'

module Yesradio
  
  YESRADIO_VERSION = 1
  YESRADIO_SERVER = "http://api.yes.com/#{YESRADIO_VERSION}"

  def self.element_to_station(element)
    station = Station.new
    station.elements.each do |name, type|
      new_value = get_element_child element, name.gsub('_', '/'), type
      station.instance_variable_set("@#{name}", new_value) unless new_value.nil?
    end
    station
  end

  def self.search_stations(search_criteria)
    stations = Array.new

    url = Yesradio::YESRADIO_SERVER + "/stations?type=xml"
    url = url + search_criteria.to_query_params_string
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    doc.elements.each("//api/array/stations") do |element|
      stations << element_to_station(element)
    end
    stations
  end

  def self.match_station(name)
  # Example:
    url = Yesradio::YESRADIO_SERVER + "/station?type=xml"
    url = url + "&name=" + CGI::escape(name)
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    element_to_station(doc.elements["//api"])
  end

  protected

  def self.get_element_child(element, child, type="text")
    return if element.elements[child].nil?
    child = element.elements[child][0].to_s
    return case type
      when "int" then child.to_i
      when "float" then child.to_f 
      else child
    end

  end
  
end

