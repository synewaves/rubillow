module Rubillow
  module Models
    # 
    class Chart < Base
      attr_accessor :height
      attr_accessor :width
      attr_accessor :url
      
      def to_html
        "<img src='#{@url}' height='#{@height}' width='#{width}' />"
      end
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @height = @parser.xpath('//request/height').text.to_i
        @width = @parser.xpath('//request/width').text.to_i
        @url = @parser.xpath('//response/url').text
      end
    end
  end
end