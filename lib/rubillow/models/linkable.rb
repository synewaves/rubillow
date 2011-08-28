module Rubillow
  module Models
    # Common data for responses containing links
    module Linkable
      # @return [Hash] Links (format: :name => 'url')
      #
      # @example
      #   links.each do |name, url
      #   end
      # 
      attr_accessor :links
      
      protected
      
      # @private
      def extract_links(xml)
        @links = {}
        
        # TODO: clean up this logic
        if !xml.xpath('//result/links').empty?
          selector = '//result/links'
        elsif !xml.xpath('//response/links').empty?
          selector = '//response/links'
        elsif !xml.xpath('//principal/links').empty?
          selector = '//principal/links'
        elsif !xml.xpath('//comp/links').empty?
          selector = '//comp/links'
        else
          selector = '//links'
        end
        
        xml.xpath(selector).children.each do |link|
          next if link.name == "myzestimator" # deprecated
          @links[link.name.to_sym] = link.text
        end
      end
    end
  end
end