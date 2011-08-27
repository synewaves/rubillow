module Rubillow
  module Models
    #
    module PropertyBasics
      attr_accessor :use_code
      attr_accessor :lot_size_square_feet
      attr_accessor :finished_square_feet
      attr_accessor :bathrooms
      attr_accessor :bedrooms
      attr_accessor :total_rooms
      
      protected
      
      def extract_property_basics(xml)
        @use_code = xml.xpath('//useCode').text
        @lot_size_square_feet = xml.xpath('//lotSizeSqFt').text
        @finished_square_feet = xml.xpath('//finishedSqFt').text
        @bathrooms = xml.xpath('//bathrooms').text
        @bedrooms = xml.xpath('//bedrooms').text
        @total_rooms = xml.xpath('//totalRooms').text
      end
    end
  end
end