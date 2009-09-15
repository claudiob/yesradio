#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================
require 'item'
module Yesradio
  class Station < Item
    @elements = {'name' => :text, 'desc' => :text, 'genre' => :text, 
                  'market' => :text, 'type' => :text, 'id' => :int, 
                  'tz' => :text, 'stream' => :text, 'yes' => :text, 
                  'relay' => :text, 'audiostream' => :text, 'array_id' => :int,
                  'array_song' => :text, 'array_artist' => :text}
    attr_accessor *@elements.keys
  end
end


