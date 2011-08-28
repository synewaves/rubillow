module Rubillow
  # Interface for the Mortgage API.
  # 
  # Read the more about this API at: {http://www.zillow.com/howto/api/MortgageAPIOverview.htm}
  class Mortgage
    # Retrieve the current rates for today and one week ago for each loan type.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetRateSummary.htm}.
    # 
    # @example
    #   data = Rubillow::Mortgage.rate_summary
    #   
    #   if data.success?
    #     puts data.today[:thirty_year_fixed]        # "4.01"
    #     puts data.today[:five_one_arm]             # "2.73"
    #     puts data.last_week[:fifteen_year_fixed]   # "3.27"
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :state   The state to limit rates.
    # @return [Models::RateSummary] Mortgage rate summary.
    def self.rate_summary(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :state => nil,
      }.merge!(options)
      options[:output] = 'xml'
    
      Models::RateSummary.new(Rubillow::Request.get("GetRateSummary", options))
    end
    
    # Retrieve the current monthly payment information for a given loan amount
    #
    # Read more at: {http://www.zillow.com/howto/api/GetMonthlyPayments.htm}.
    # 
    # \* Either the down or dollars down options are required.
    #
    # @example
    #   data = Rubillow::Mortgage.monthly_payments({ :price => "300000", :down => "15", :zip => "98104" })
    #   
    #   if data.success?
    #     puts data.thirty_year_fixed[:rate]                # "4.01"
    #     puts data.thirty_year_fixed[:mortgage_insurance]  # "93"
    #
    #     puts data.down_payment                            # "45000"
    #     puts data.monthly_property_taxes                  # "193"
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Float] :price        The loan amount. (required)
    # @option options [Float] :down         The percentage of the price as a down payment. Defaults to 20%. If less than 20%, private mortgage insurance is returned. (required *)
    # @option options [Float] :dollarsdown  The dollar amount as down payment. Used if down option is omitted. If less than 20% of total price, private mortgage insurance is returned. (required *)
    # @option options [String] :zip         The ZIP code for the property. If provided, property tax and hazard insurance will be returned.
    # @return [Models::MonthlyPayments] Monthly mortage information.
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