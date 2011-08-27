module Rubillow
  module Models
    # Chart for a property
    class PropertyChart < Chart
      # @return [String] url for chart
      attr_accessor :graphs_and_data
    
      # Returns HTML for the chart.
      # @return [String] chart HTML.
      def to_html
        "<a href='#{@graphs_and_data}'>" + super + "</a>"
      end
    
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        @graphs_and_data = @parser.xpath('//response/graphsanddata').text
      end
    end
  end
end