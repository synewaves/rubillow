module Rubillow
  module Models
    # 
    class Posting < Base
      include Zpidable
      include Addressable
      include Linkable
      include PropertyBasics
      include Images
      
      attr_accessor :last_refreshed_date
      attr_accessor :images_count
      attr_accessor :price
      
      protected
      
      def parse
        super
        
        return if !success?
        
        property = @parser.xpath('//property').first
        extract_zpid(property)
        extract_links(property)
        extract_address(property)
        extract_property_basics(property)
        extract_images(property)
        
        @last_refreshed_date = Date.strptime(@parser.xpath('//lastRefreshedDate').text, "%Y-%m-%d")
        @price = @parser.xpath('//price').text
      end
    end
  end
end