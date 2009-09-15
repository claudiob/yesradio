# Author::    Claudio Baccigalupo
# Copyright:: Copyright (c) 2009 - see LICENSE file

require 'cgi'
require 'net/http'
require 'rexml/document'

require 'station'
require 'stations_search_criteria'
require 'song'

module Yesradio
  
  YESRADIO_VERSION = 1
  YESRADIO_SERVER = "http://api.yes.com/#{YESRADIO_VERSION}"

  # Get current information about a single station including now playing song, 
  # slogan, frequency, market, and links to any known webcast stream or site.
  #
  # == Parameters
  # [+name+] The station name (for AM/FM it is just the call letters).
  #
  # == Examples
  #     get_station :name => "KEXP"
  #--
  def self.get_station(query_hash)
    array = self.search('Station', "station", "//api", query_hash)
    array[0] unless array.nil? || array[0].name.nil?
  end

  # Search and find a list of stations by name, frequency, genre, artist, 
  # or location.
  #
  # == Parameters
  # [+match+] [optional] Used to search station names, call letters, slogans, frequency, or cities/states.
  # [+freq+] [optional] Also match an exact AM/FM frequency.
  # [+mid+] [optional] Also match only stations that have this media id (see #media call) in their top 100 charts.
  # [+genre+] [optional] Also match any genre keywords like pop, rock, etc.
  # [+loc+] [optional] Also match stations within 60 miles of the given zip code, "lat,lon", or city/state names.
  # [+max+] [optional] Defaults to 10 stations returned.
  #
  # == Examples
  #     search_stations :match => "KEX"
  #--
  def self.search_stations(query_hash)
    self.search('Station', "stations", "//api/array/stations", query_hash)
  end

  # Get the log of all the songs played on the given station in a selected day 
  # within the last week. 
  #
  # == Parameters
  # [+name+] The station name.
  # [+ago+] [optional] The days ago from now for the given date you want, an integer from 0-6 and defaults to 0 (the log today so far).
  #
  # == Examples
  #     get_log :name => "KEXP", :ago => 3
  #--
  def self.get_log(query_hash)
    self.search('Song', "log", "//api/array/songs", query_hash)
  end

  # Get the most recent songs played on any station.
  #
  # == Parameters
  # [+name+] The station name.
  # [+max+] How many recent songs to return (default is 10).
  #
  # == Examples
  #     get_recent :name => "KEXP", :max => 3
  #--
  def self.get_recent(query_hash)
    self.search('Song', "recent", "//api/array/songs", query_hash)
  end

  # Get the current top 100 songs for any station based on number of times 
  # played and user voting (calculated daily).
  #
  # == Parameters
  # [+name+] [optional] The station name, defaults to US national top 100 if none given.
  # [+date+] [optional] Return just the charts from a specific date in the format year-mm-dd (April 2008 and newer).
  # [+genre+] [optional] Filter any request to a specific Genre ( Americana Blues Christian Classical Country Electronica Hip-Hop Jazz Latin Metal New Age Pop Punk R&B/Soul Rock Smooth Jazz World ).
  # [+hot+] [optional] Alternative sorting, must be either "fresh" (by most increase in charts day-to-day, not supported in combination with date field) or "vote" (most votes via yes.com).
  # [+max+] How many songs to return (default is 10).
  #
  # == Examples
  #     get_chart :genre => "Rock"
  #--
  def self.get_chart(query_hash)
    self.search('Song', "chart", "//api/array/songs", query_hash)
  end

  # Get a list of any matching artist names or song titles based on airtime 
  # popularity.
  #
  # == Parameters
  # [+q+] The string to search with, can be partial (used for autocomplete) or full names.
  # [+aid+] [optional] Instead of a general query, a known Artist ID can be passed to return just media from that artist.
  # [+mid+] [optional] Instead of a general query, a known Media ID can be passed to return extra information (lyrics from Lyric Wiki and matching videos from YouTube and MTV) about just that song.
  # [+max+] How many songs to return (default is 10, max is 50).  
  #
  # == Examples
  #     get_media :aid => 610471
  #--
  # Run test with http://api.yes.com/1/media?mid=12812281&type=xml
  # which returns an XML error (Yes.com's fault)
  def self.get_media(query_hash)
    self.search('Song', "media", "//api/array/songs", query_hash)
  end

  # Given a song, return a list of related songs based on airtime in the last 
  # week.
  #
  # == Parameters
  # [+mid+] The media ID (use media call to search for IDs).
  # [+max+] Maximum number of related songs to return (default is 20).
  #
  # == Examples
  #     get_related :mid => 11586843
  #--
  def self.get_related(query_hash)
    self.search('Song', "related", "//api/array/songs", query_hash)
  end

  protected
  
  def self.search(item_class, action, xml_element, query_hash)
    url = create_url(action, query_hash)
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path + '?' + uri.query)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    doc = REXML::Document.new res.body
    return if doc.elements[xml_element].nil?
    doc.elements.collect(xml_element) do |element|
      eval "#{item_class}.new(element)"
    end
  end
  
  def self.create_url(action, query_hash)
    url = Yesradio::YESRADIO_SERVER + "/#{action}?type=xml"
    query_hash.each do |name, value|
      url = url + "&#{name}=" + CGI::escape(value.to_s) unless value.nil?  
    end
    url
  end
  
end
