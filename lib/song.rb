#=============================================================================
#
# 2009 Claudio Baccigalupo
#
# Licensed under the Ruby License
#
#=============================================================================

module Yesradio
  class Song
    @@elements = {'at' => :datetime, 'by' => :text, 'title' => :text, 
                  'id' => :int, 'type' => :text, 'rank' => :int, 
                  'cover' => :text, 'video' => :text, 'ago' => :int}
    attr_accessor *@@elements.keys
    def elements
      @@elements
    end  
  end
end


