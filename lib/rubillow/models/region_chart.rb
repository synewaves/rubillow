module Rubillow
  module Models
    #  Chart for a region
    class RegionChart < Chart
      include Linkable
      
      # @return [String] url for chart
      attr_accessor :link
    
      # Returns HTML for the chart.
      # @return [String] chart HTML.
      def to_html
        "<a href='#{@link}'>" + super + "</a>"
      end
    
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        extract_links(@parser)
        
        @link = @parser.xpath('//response/link').text
      end
    end
  end
end