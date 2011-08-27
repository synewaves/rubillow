module Rubillow
  module Models
    module Zpidable
      attr_accessor :zpid
      
      protected
      
      def extract_zpid(xml)
        # TODO: clean up this logic
        if !xml.xpath('//response/zpid').empty?
          selector = '//response/zpid'
        elsif !xml.xpath('//result/zpid').empty?
          selector = '//result/zpid'
        else
          selector = '//zpid'
        end
        
        @zpid = xml.xpath(selector).text
      end
    end
  end
end