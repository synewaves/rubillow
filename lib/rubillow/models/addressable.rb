module Rubillow
  module Models
    # Common data for responses containing address information.
    module Addressable
      # @return [Hash] Address information (all are strings, keys are: :street, :city, :state, :zipcode, :latitude, :longitude).
      #
      # @example
      #   puts address[:street]
      #   puts address[:city]
      #
      attr_accessor :address
      
      # get the full, formatted address
      # 
      # @return [String] formatted address
      def full_address
        @address[:street] + ', ' + @address[:city] + ', ' + @address[:state] + ' ' + @address[:zipcode]
      end
      
      protected
      
      # @private
      def extract_address(xml)
        address = xml.xpath('//address')
        if !address.empty?
          @address = {
            :street    => address.xpath('//street').text,
            :city      => address.xpath('//city').text,
            :state     => address.xpath('//state').text,
            :zipcode   => address.xpath('//zipcode').text,
            :latitude  => address.xpath('//latitude').text,
            :longitude => address.xpath('//longitude').text,
          }
        end
      end
    end
  end
end