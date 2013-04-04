module Rubillow
  module Models
    # Base chart class.
    class Chart < Base
      # @return [String] image height.
      attr_accessor :height
      
      # @return [String] image width.
      attr_accessor :width
      
      # @return [String] URL to image.
      attr_accessor :url
      
      # Returns HTML for the chart.
      # @return [String] chart HTML.
      def to_html
        "<img src='#{@url}' height='#{@height}' width='#{width}' />"
      end
      
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        @height = @parser.xpath('//request/height').first.text.to_i
        @width = @parser.xpath('//request/width').first.text.to_i
        @url = @parser.xpath('//response/url').first.text
      end
    end
  end
end