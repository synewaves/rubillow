module Rubillow
  class PropertyDetails
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