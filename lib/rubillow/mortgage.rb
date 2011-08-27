module Rubillow
  class Mortgage
    def self.rate_summary(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :state => nil,
      }.merge!(options)
      options[:output] = 'xml'
    
      Models::RateSummary.new(Rubillow::Request.get("GetRateSummary", options))
    end
    
    def self.monthly_payments(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :price => nil,
        :down => nil,
        :dollarsdown => nil,
        :zip => nil,
      }.merge!(options)
      options[:output] = 'xml'
      
      if options[:price].nil?
        raise ArgumentError, "The price option is required"
      end
      if options[:down].nil? && options[:dollarsdown].nil?
        raise ArgumentError, "Either the down or dollarsdown option is required"
      end
    
      Models::MonthlyPayments.new(Rubillow::Request.get("GetMonthlyPayments", options))
    end
  end
end