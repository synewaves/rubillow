module Rubillow
  module Models
    # Demographic data point.
    class DemographicValue
      # @return [String] data point value.
      attr_accessor :value
      
      # @return [String] data point type.
      attr_accessor :type
      
      # create a new data point.
      # @param [String] xml for point.
      def initialize(xml)
        if !xml.empty?
          @value = xml.text
          @type = xml.attribute('type').value if !xml.attribute('type').nil?
        end
      end
      
      # Prints value
      #
      # @return [String] attribute value
      def to_s
        @value
      end
    end
  end
end