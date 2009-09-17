# Author::    Claudio Baccigalupo
# Copyright:: Copyright (c) 2009 - see LICENSE file

require 'date'

module Yesradio
  class Item
    class << self
      attr_accessor :elements 
    end
    
    def initialize(element = nil)
      self.class.elements.each do |name, type|
        new_value = get_element_child element, name.gsub('_', '/'), type
        self.instance_variable_set("@#{name}", new_value) unless new_value.nil?
      end
    end

    private

    def get_element_child(element, child, type = :text)
      return if element.nil? || element.xpath(child).empty?
      child = element.xpath(child).text.to_s
      return case type
        when :int then child.to_i
        when :float then child.to_f 
        when :datetime then DateTime.parse(child)
        else child
      end

    end

  end
end


