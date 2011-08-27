module Rubillow
  module Models
    class DemographicValue
      attr_accessor :value
      attr_accessor :type
      
      def initialize(xml)
        if !xml.empty?
          @value = xml.text
          @type = xml.attribute('type').value if !xml.attribute('type').nil?
        end
      end
    end
  end
end