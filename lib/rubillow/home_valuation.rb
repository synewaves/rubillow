module Rubillow
  class HomeValuation
    def self.search_results(options = {})
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
    
      Models::SearchResult.new(Rubillow::Request.get("GetSearchResults", options))
    end
    
    def self.zestimate(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
      }.merge!(options)
      
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
      
      Models::SearchResult.new(Rubillow::Request.get("GetZestimate", options))
    end

    def self.chart(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zpid => nil,
        :unit_type => nil,
      }.merge!(options)
    
      if options[:zpid].nil?
        raise ArgumentError, "The zpid option is required"
      end
      if options[:unit_type].nil?
        raise ArgumentError, "The unit_type option is required"
      end
      
      Models::PropertyChart.new(Rubillow::Request.get("GetChart", options))
    end

    def self.comps(options = {})
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
      
      Models::Comps.new(Rubillow::Request.get("GetComps", options))
    end
  end
end