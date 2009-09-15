# Author::    Claudio Baccigalupo
# Copyright:: Copyright (c) 2009 - see LICENSE file

require 'item'
module Yesradio
  class Song < Item
    @elements = {'at' => :datetime, 'by' => :text, 'title' => :text, 
                  'id' => :int, 'type' => :text, 'rank' => :int, 
                  'cover' => :text, 'video' => :text, 'link' => :text,
                  'ago' => :int}
    attr_accessor *@elements.keys
  end
end


