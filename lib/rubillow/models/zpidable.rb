module Rubillow
  module Models
    # Common data for responses containing zpid's
    module Zpidable
      # @return [String] ZPID of property
      attr_accessor :zpid
      
      protected
      
      # @private
      def extract_zpid(xml)
        # TODO: clean up this logic
        if !xml.xpath('//response/zpid').empty?
          selector = '//response/zpid'
        elsif !xml.xpath('//result/zpid').empty?
          selector = '//result/zpid'
        else
          selector = '//zpid'
        end
        
        @zpid = xml.xpath(selector).first.text
      end
    end
  end
end