module Rubillow
  class Postings
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