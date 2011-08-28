module Rubillow
  module Models
    # List of comps for a given property with deep data.
    class DeepComps < Base
      # @return [Models::DeepSearchResult] principal property.
      attr_accessor :principal
      
      # @return [Hash] comparables list (key => comparable's score, value => {Models::DeepSearchResult}).
      #
      # @example
      #  comparables.each do |score, comp|
      #    puts score
      #    puts comp.price
      #  end
      attr_accessor :comparables
      
      protected
      
      # @private
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