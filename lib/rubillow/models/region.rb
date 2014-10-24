module Rubillow
  module Models
    # Region information.
    class Region < Base
      # @return [String] region id.
      attr_accessor :id

      # @return [String] state.
      attr_accessor :state

      # @return [String] city.
      attr_accessor :city

      # @return [String] neighborhood.
      attr_accessor :neighborhood

      # @return [String] latitude.
      attr_accessor :latitude

      # @return [String] longitude.
      attr_accessor :longitude

      # @return [String] ZMM rate URL.
      attr_accessor :zmmrateurl

      protected

      # @private
      def parse
        super

        return if !success?

        @id = @parser.xpath('//id').first.text
        @state = @parser.xpath('//state').text
        @city = @parser.xpath('//city').text
        @neighborhood = @parser.xpath('//name').text
        @latitude = @parser.xpath('//latitude').text
        @longitude = @parser.xpath('//longitude').text
        @zmmrateurl = @parser.xpath('//zmmrateurl').text
      end
    end
  end
end
