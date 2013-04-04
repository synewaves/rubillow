module Rubillow
  module Models
    # Common data for responses containing property information
    module PropertyBasics
      # @return [String] property type
      attr_accessor :use_code
      
      # @return [String] Size of lot in square feet
      attr_accessor :lot_size_square_feet
      
      # @return [String] Size of property in square feet
      attr_accessor :finished_square_feet
      
      # @return [String] number of bathrooms
      attr_accessor :bathrooms
      
      # @return [String] number of bedrooms
      attr_accessor :bedrooms
      
      # @return [String] total number of rooms
      attr_accessor :total_rooms
      
      protected
      
      # @private
      def extract_property_basics(xml)
        @use_code = ""
        @use_code = xml.xpath('//useCode').first.text unless xml.xpath('//useCode').empty?
        @lot_size_square_feet = xml.xpath('//lotSizeSqFt').text
        @finished_square_feet = xml.xpath('//finishedSqFt').first.text
        @bathrooms = xml.xpath('//bathrooms').first.text
        @bedrooms = xml.xpath('//bedrooms').first.text
        @total_rooms = xml.xpath('//totalRooms').text
      end
    end
  end
end