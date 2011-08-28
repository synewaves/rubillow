module Rubillow
  module Models
    # Common data for responses containing images
    module Images
      # @return [Array] List of image urls
      attr_accessor :images
      
      # @return [Integer] number of images available (doesn't always match @images.count)
      attr_accessor :images_count
      
      protected
      
      # @private
      def extract_images(xml)
        @images_count = xml.xpath('//images/count').text
        
        @images = []
        xml.xpath('//images/image').children.each do |elm|
          @images << elm.text
        end
      end
    end
  end
end