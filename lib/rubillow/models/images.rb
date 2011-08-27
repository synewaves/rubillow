module Rubillow
  module Models
    # 
    module Images
      attr_accessor :images
      attr_accessor :images_count
      
      protected
      
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