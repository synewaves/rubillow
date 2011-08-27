module Rubillow
  class Neighborhood
    def self.demographics(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :regionid => nil,
        :state => nil,
        :city => nil,
        :neighborhood => nil,
        :zip => nil,
      }.merge!(options)
    
      if options[:regionid].nil? && options[:zip].nil? && (options[:state].nil? || options[:city].nil?) && (options[:city].nil? || options[:neighborhood].nil?)
        raise ArgumentError, "The regionid, state and city, city and neighborhood or zip option is required"
      end 
    
      Models::Demographics.new(Rubillow::Request.get("GetDemographics", options))
    end
    
    def self.region_children(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :regionid => nil,
        :state => nil,
        :county => nil,
        :city => nil,
        :childtype => nil,
      }.merge!(options)
    
      if options[:regionid].nil? && options[:state].nil?
        raise ArgumentError, "The regionid or state option is required"
      end 
    
      Models::RegionChildren.new(Rubillow::Request.get("GetRegionChildren", options))
    end
    
    def self.region_chart(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :city => nil,
        :state => nil,
        :neighborhood => nil,
        :zip => nil,
        :unit_type => nil,
        :width => nil,
        :height => nil,
        :chartDuration => nil,
      }.merge!(options)
    
      if options[:unit_type].nil?
        raise ArgumentError, "The unit_type option is required"
      end 
    
      Models::RegionChart.new(Rubillow::Request.get("GetRegionChart", options))
    end
  end
end