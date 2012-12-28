module Rubillow
  # Interface for the Property Details API.
  # 
  # Read the more about this API at: {http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm}
  class PropertyDetails
    # Retrieve extended details for a property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetDeepSearchResults.htm}.
    #
    # @example
    #   data = Rubillow::PropertyDetails.deep_search_results({ :address => '2114 Bigelow Ave', :citystatezip => 'Seattle, WA' })
    #   
    #   if data.success?
    #     puts data.tax_assessment_year  # "2010"
    #     puts data.last_sold_price      # "1025000"
    #     puts data.address[:latitude]   # "47.637933"
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String]  :address        The address of the property to search. (required)
    # @option options [String]  :citystatezip   The city+state combination and/or ZIP code for which to search. Note that giving both city and state is required. Using just one will not work. (required)
    # @option options [Boolean] :rentzestimate  Return Rent Zestimate information if available. Default: false
    # @return [Models::DeepSearchResult] Extended property details.
    def self.deep_search_results(options = {})
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
    
      Models::DeepSearchResult.new(Rubillow::Request.get("GetDeepSearchResults", options))
    end
    
    # Retrieve extended details for property and its comps.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetDeepComps.htm}.
    #
    # @example
    #   data = Rubillow::PropertyDetails.deep_comps({ :zpid => '48749425', :count => 5 })
    #   
    #   if data.success?
    #     puts data.principal.price  # "1032000"
    #     data.comparables.each |comp|
    #       puts comp.price
    #       puts comp.address[:street]
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid           The Zillow Property ID of the property. (required)
    # @option options [Integer] :count          The number of comps to return, between 1 and 25 inclusive. (required)
    # @option options [Boolean] :rentzestimate  Return Rent Zestimate information if available. Default: false
    # @return [Models::DeepComps] Extended property and comp details.
    def self.deep_comps(options = {})
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
    
      Models::DeepComps.new(Rubillow::Request.get("GetDeepComps", options))
    end
    
    # Retrieve updated property facts for a given property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm}.
    #
    # @example
    #   data = Rubillow::PropertyDetails.updated_property_details({ :zpid => '48749425' })
    #   
    #   if data.success?
    #     puts data.posting[:status]  # "1032000"
    #     puts data.posting[:type]    # "For sale by agent"
    #     data.edited_facts.each |fact|
    #       puts fact
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid   The Zillow Property ID of the property. (required)
    # @return [Models::UpdatedPropertyDetails] Updated property information.
    def self.updated_property_details(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
      }.merge!(options)
    
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
    
      Models::UpdatedPropertyDetails.new(Rubillow::Request.get("GetUpdatedPropertyDetails", options))
    end
  end
end
