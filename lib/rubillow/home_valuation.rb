module Rubillow
  # Interface for the Home Valuation API.
  # 
  # Read the more about this API at: {http://www.zillow.com/howto/api/HomeValuationAPIOverview.htm}
  class HomeValuation
    # Retrieve a property by the specified address.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetSearchResults.htm}.
    # 
    # @example
    #   data = Rubillow::HomeValuation.search_results({ :address => '2114 Bigelow Ave', :citystatezip => 'Seattle, WA' })
    #   
    #   if data.success?
    #     puts data.zpid    # "48749425" 
    #     puts data.price   # "1032000"
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String]  :address        The address of the property to search. (required)
    # @option options [String]  :citystatezip   The city+state combination and/or ZIP code for which to search. Note that giving both city and state is required. Using just one will not work. (required)
    # @option options [Boolean] :rentzestimate  Return Rent Zestimate information if available. Default: false
    # @return [Models::SearchResult] Property information.
    def self.search_results(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :address => nil,
        :citystatezip => nil,
        :rentzestimate => false,
      }.merge!(options)
    
      if options[:address].nil?
        raise ArgumentError, "The address option is required"
      end
      if options[:citystatezip].nil?
        raise ArgumentError, "The citystatezip option is required"
      end
    
      Models::SearchResult.new(Rubillow::Request.get("GetSearchResults", options))
    end
    
    # Retrieve a zestimate for the specified property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetZestimate.htm}.
    # 
    # @example
    #   data = Rubillow::HomeValuation.zestimate({ :zpid => '48749425' })
    #   
    #   if data.success?
    #     puts data.zpid          # "48749425" 
    #     puts data.price         # "1032000"
    #     puts data.value_change  # "5900"
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid           The Zillow Property ID of the property. (required)
    # @option options [Boolean] :rentzestimate  Return Rent Zestimate information if available. Default: false
    # @return [Models::SearchResult] Property pricing information.
    def self.zestimate(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
        :rentzestimate => false,
      }.merge!(options)
      
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
      
      Models::SearchResult.new(Rubillow::Request.get("GetZestimate", options))
    end

    # Retrieve a chart for the specified property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetChart.htm}.
    # 
    # @example
    #   chart = Rubillow::HomeValuation.chart({ :zpid => '48749425', :height => '300', :width => '150' })
    #   
    #   if chart.success?
    #     puts chart.to_html
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid           The Zillow Property ID of the property. (required)
    # @option options [String]  :unit-type      Show the percent change ("percent"), or dollar change ("dollar"). (required)
    # @option options [Integer] :width          The width of the image; between 200 and 600, inclusive.
    # @option options [Integer] :height         The height of the image; between 100 and 300, inclusive.
    # @option options [Integer] :chartDuration  The duration of past data to show. Valid values are "1year", "5years" and "10years". If unspecified, the value defaults to "1year".
    # @return [Models::PropertyChart] Property chart.
    def self.chart(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
        :unit_type => nil,
        :width => nil,
        :height => nil,
        :chartDuration => nil,
      }.merge!(options)
    
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
      if options[:unit_type].nil?
        raise ArgumentError, "The unit_type option is required"
      end
      
      Models::PropertyChart.new(Rubillow::Request.get("GetChart", options))
    end

    # Retrieve a list of comps for the specified property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetComps.htm}.
    # 
    # @example
    #   data = Rubillow::HomeValuation.comps({ :zpid => '48749425', :count => 5 })
    #   
    #   if data.success?
    #     puts data.principal.price  # "1032000"
    #     data.comparables.each do |comp|
    #       puts comparables.price
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid           The Zillow Property ID of the property. (required)
    # @option options [Integer] :count          The number of comps to return, between 1 and 25 inclusive. (required)
    # @option options [Boolean] :rentzestimate  Return Rent Zestimate information if available. Default: false
    # @return [Models::Comps] Comps Property information and comps list.
    def self.comps(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
        :count => nil,
        :rentzestimate => false,
      }.merge!(options)
    
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
      if options[:count].nil?
        raise ArgumentError, "The count option is required"
      end
      
      Models::Comps.new(Rubillow::Request.get("GetComps", options))
    end
  end
end