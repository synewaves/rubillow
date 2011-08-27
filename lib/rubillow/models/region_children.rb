module Rubillow
  module Models
    #
    class RegionChildren < Base
      attr_accessor :region
      attr_accessor :regions
      
      protected
      
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