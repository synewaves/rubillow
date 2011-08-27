module Rubillow
  module Models
    #
    module Addressable
      attr_accessor :address
      
      protected
      
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