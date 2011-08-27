module Rubillow
  module Models
    # 
    class RegionChart < Chart
      include Linkable
      
      attr_accessor :link
    
      def to_html
        "<a href='#{@link}'>" + super + "</a>"
      end
    
      protected
      
      def parse
        super
        
        return if !success?
        
        extract_links(@parser)
        
        @link = @parser.xpath('//response/link').text
      end
    end
  end
end