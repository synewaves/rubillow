module Rubillow
  module Models
    # 
    class PropertyChart < Chart
      attr_accessor :graphs_and_data
    
      def to_html
        "<a href='#{@graphs_and_data}'>" + super + "</a>"
      end
    
      protected
      
      def parse
        super
        
        return if !success?
        
        @graphs_and_data = @parser.xpath('//response/graphsanddata').text
      end
    end
  end
end