module Rubillow
  module Models
    # List of sub-regions for a region
    class RegionChildren < Base
      # @return [Models::Region] top-level region
      attr_accessor :region
      
      # @return [Array] sub-level regions ({Models::Region})
      attr_accessor :regions
      
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        @region = Region.new(@parser.xpath('//response/region').to_xml)
        
        @regions = []
        @parser.xpath('//response/list').children.each do |region|
          if region.name == "region"
            @regions << Region.new(region.to_xml)
          end
        end
      end
    end
  end
end