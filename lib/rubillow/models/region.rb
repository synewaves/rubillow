module Rubillow
  module Models
    # 
    class Region < Base
      attr_accessor :id
      attr_accessor :state
      attr_accessor :city
      attr_accessor :neighborhood
      attr_accessor :latitude
      attr_accessor :longitude
      attr_accessor :zmmrateurl
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @id = @parser.xpath('//id').text
        @state = @parser.xpath('//state').text
        @city = @parser.xpath('//city').text
        @neighborhood = @parser.xpath('//neighborhood').text
        @latitude = @parser.xpath('//latitude').text
        @longitude = @parser.xpath('//longitude').text
        @zmmrateurl = @parser.xpath('//zmmrateurl').text
      end
    end
  end
end