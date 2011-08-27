module Rubillow
  # Interface for the Property Details API.
  # 
  # Read the more about this API at: {http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm}
  class PropertyDetails
    # Retrieve extended details for a property.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetDeepSearchResults.htm}.
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :address       The address of the property to search. (required)
    # @option options [String] :citystatezip  The city+state combination and/or ZIP code for which to search. Note that giving both city and state is required. Using just one will not work. (required)
    # @return [Models::DeepSearchResult] Extended property details.
    def self.deep_search_results(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :address => nil,
        :citystatezip => nil,
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
    # @param [Hash] options The options for the API request.
    # @option options [Integer] :zpid   The Zillow Property ID of the property. (required)
    # @option options [Integer] :count  The number of comps to return, between 1 and 25 inclusive. (required)
    # @return [Models::DeepComps] Extended property and comp details.
    def self.deep_comps(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
        :count => nil,
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
    
      Models::UpdatedPropertyDetails.new(Rubillow::Request.get("GetUpdatePropertyDetails", options))
    end
  end
end