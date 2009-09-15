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
require 'date'

require 'station'
require 'stations_search_criteria'
require 'song'

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

  # TO DO, dry with the previous function
  def self.element_to_song(element)
    song = Song.new
    song.elements.each do |name, type|
      new_value = get_element_child element, name.gsub('_', '/'), type
      song.instance_variable_set("@#{name}", new_value) unless new_value.nil?
    end
    song
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

  def self.get_station(station_name)
    url = Yesradio::YESRADIO_SERVER + "/station?type=xml"
    url = url + "&name=" + CGI::escape(station_name)
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    element_to_station(doc.elements["//api"])
  end

  def self.get_log(station_name, ago = nil)
    songs = Array.new
    
    url = Yesradio::YESRADIO_SERVER + "/log?type=xml"
    url = url + "&name=" + CGI::escape(station_name)
    url = url + "&ago=" + CGI::escape(ago.to_s) unless ago.nil?
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    doc.elements.each("//api/array/songs") do |element|
      songs << element_to_song(element)
    end
    songs
  end

  def self.get_recent(station_name, max = nil)
    songs = Array.new
    
    url = Yesradio::YESRADIO_SERVER + "/recent?type=xml"
    url = url + "&name=" + CGI::escape(station_name)
    url = url + "&max=" + CGI::escape(max.to_s) unless max.nil?
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    doc.elements.each("//api/array/songs") do |element|
      songs << element_to_song(element)
    end
    songs
  end

  protected

  def self.get_element_child(element, child, type = :text)
    return if element.elements[child].nil?
    child = element.elements[child][0].to_s
    return case type
      when :int then child.to_i
      when :float then child.to_f 
      when :datetime then DateTime.parse(child)
      else child
    end

  end
  
end

