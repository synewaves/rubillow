module Rubillow
  # Interface for the Neighborhood API.
  # 
  # Read the more about this API at: {http://www.zillow.com/webtools/neighborhood-data/}
  class Neighborhood
    # Retrieve demographic data for a given region.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetDemographics.htm}.
    #
    # \* At least regionid or state/city, city/neighborhood, or zip options are required.
    # 
    # @example
    #   data = Rubillow::Neighborhood.demographics({ :state => 'WA', :city => 'Seattle', :neighborhood => 'Ballard' })
    #   
    #   if data.success?
    #     puts data.charts['Median Condo Value']
    #     puts data.affordability_data['Zillow Home Value Index'][:neighborhood]
    #     data.characteristics.each do |stat|
    #       stat
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :regionid      The id of the region (required *)
    # @option options [String] :state         The state of the region (required *)
    # @option options [String] :city          The city of the region (required *)
    # @option options [String] :neighborhood  The neighborhood of the region (required *)
    # @option options [String] :zip           The zopcode of the region (required *)
    # @return [Models::Demographics] Region demographics data.
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
    
    # Retrieve sub-regions for a region
    #
    # Read more at: {http://www.zillow.com/howto/api/GetRegionChildren.htm}.
    #
    # \* At least regionid or state options are required.
    # 
    # @example
    #   data = Rubillow::Neighborhood.region_children({ :state => 'WA', :city => 'Seattle', :childtype => 'neighborhood' })
    #   
    #   if data.success?
    #     puts data.region.id        # "16037"
    #     puts data.region.latitude  # "47.559364"
    #     data.regions.each do |region|
    #       puts region.id
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String] :regionid   The id of the region (required *)
    # @option options [String] :state      The state of the region (required *)
    # @option options [String] :county     The county of the region
    # @option options [String] :city       The city of the region
    # @option options [String] :childType  The type of regions to retrieve (available types: +state+, +county+, +city+, +zipcode+, and +neighborhood+)
    # @return [Models::RegionChildren] Region children list.
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
    
    # Retrieve a chart for the specified region.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetRegionChart.htm}.
    # 
    # @example
    #   chart = Rubillow::Neighborhood.chart({ :city => 'Seattle', :state => 'WA', :unit_type => 'percent', :width => 300, :height => 150 })
    #   
    #   if chart.success?
    #     puts chart.to_html
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String]  :city           The city of the region
    # @option options [String]  :state          The state of the region
    # @option options [String]  :neighborhood   The county of the region
    # @option options [String]  :zip            The zipcode of the region
    # @option options [String]  :unit-type      Show the percent change (+percent+), or dollar change (+dollar+). (required)
    # @option options [Integer] :width          The width of the image; between 200 and 600, inclusive.
    # @option options [Integer] :height         The height of the image; between 100 and 300, inclusive.
    # @option options [Integer] :chartDuration  The duration of past data to show. Valid values are +1year+, +5years+ and +10years+. Defaults to +1year+.
    # @return [Models::RegionChart] Region chart.
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