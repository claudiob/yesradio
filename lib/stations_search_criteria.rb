#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================

module Yesradio
  class StationsSearchCriteria

    attr_accessor :match, :freq, :mid, :genre, :loc, :max
  
    def initialize(options = {})
      options.each do |key, value|
        eval("@#{key} = '#{value.to_s}'")
      end
    end

    def to_query_params_string
      url = ''
      url = url + "&match=" + CGI::escape(@match) if !@match.nil?
      url = url + "&freq=" + CGI::escape(@freq) if !@freq.nil? 
      url = url + "&mid=" + CGI::escape(@mid.to_s) if !@mid.nil?
      url = url + "&genre=" + CGI::escape(@genre) if !@genre.nil?
      url = url + "&loc=" + CGI::escape(@loc) if !@loc.nil?
      url = url + "&max=" + CGI::escape(@max.to_s) if !@max.nil? 
      url
    end
  end
end


