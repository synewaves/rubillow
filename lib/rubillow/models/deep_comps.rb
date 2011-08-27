module Rubillow
  module Models
    # 
    class DeepComps < Base
      attr_accessor :principal
      attr_accessor :comparables
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @principal = DeepSearchResult.new(@parser.xpath('//principal').to_xml)
        
        @comparables = {}
        @parser.xpath('//comparables/comp').each do |elm|
          key = elm.attribute('score').value
          @comparables[key] = DeepSearchResult.new(elm.to_xml)
        end
      end
    end
  end
end