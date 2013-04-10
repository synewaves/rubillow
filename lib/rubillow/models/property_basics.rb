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
        @use_code = xpath_if_present('//useCode', :text, xml, "")
        @lot_size_square_feet = xpath_if_present('//lotSizeSqFt', :text, xml, "")
        @finished_square_feet = xpath_if_present('//finishedSqFt', :text, xml, "")
        @bathrooms = xpath_if_present('//bathrooms', :text, xml, "")
        @bedrooms = xpath_if_present('//bedrooms', :text, xml, "")
        @total_rooms = xpath_if_present('//totalRooms', :text, xml, "")
      end
    end
  end
end
