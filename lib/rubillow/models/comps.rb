module Rubillow
  module Models
    # 
    class Comps < Base
      attr_accessor :principal
      attr_accessor :comparables
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @principal = SearchResult.new(@parser.xpath('//principal').to_xml)
        
        @comparables = {}
        @parser.xpath('//comparables/comp').each do |elm|
          key = elm.attribute('score').value
          @comparables[key] = SearchResult.new(elm.to_xml)
        end
      end
    end
  end
end