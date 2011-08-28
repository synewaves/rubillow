module Rubillow
  # Interface for the Postings API.
  # 
  # Read the more about this API at: {http://www.zillow.com/howto/api/GetRegionPostings.htm}
  class Postings
    # Retrieve postings for a given region.
    #
    # Read more at: {http://www.zillow.com/howto/api/GetRegionPostings.htm}.
    #
    # \* Either the zipcode or citystatezip option is required.
    #
    # @example
    #   data = Rubillow::Postings.region_postings({ :zipcode => "98102", :rental => true })
    #   
    #   if data.success?
    #     puts data.region_id  # "99562"
    #     data.make_me_move.each do |posting|
    #       puts posting.price
    #       puts posting.address[:street]
    #     end
    #   end
    #
    # @param [Hash] options The options for the API request.
    # @option options [String]  :zipcode       The zipcode of the region (required *).
    # @option options [String]  :citystatezip  The city+state combination and/or ZIP code in which to search. Note that giving both city and state is required. Using just one will not work. (required *).
    # @option options [Boolean] :rental        Return rental properties (defaults to +false+).
    # @option options [String]  :postingType   The type of for sale listings to return. The default is +all+. To return only for sale by owner, set +fsbo+. To return only for sale by agent, set +fsba+. To return only Make Me Move, set +mmm+. Set +none+ and the rental parameter to +true+ to return only rentals.
    # @return [Models::Postings] Region postings list.
    def self.region_postings(options = {})
      options = {
        :zws_id => Rubillow.configuration.zwsid,
        :zipcode => nil,
        :citystatezip => nil,
        :rental => false,
        :postingType => 'all',
      }.merge!(options)
      options[:output] = 'xml'
      
      if options[:zipcode].nil? && options[:citystatezip].nil?
        raise ArgumentError, "Either the zipcode or citystatezip option is required"
      end
    
      Models::Postings.new(Rubillow::Request.get("GetRegionPostings", options))
    end
  end
end