module Rubillow
  module Models
    # Common data for responses containing Zestimate information
    module Zestimateable
      include Zpidable
      include Addressable
      include Linkable
      
      # @return [String] price
      attr_accessor :price
      
      # @return [Date] last updated date
      attr_accessor :last_updated
      
      # @return [Hash] valuation range (values: Strings, keys: :low, :high)
      #
      # @example
      #   puts valuation_range[:low]
      #
      attr_accessor :valuation_range
      
      # @return [String] change value
      attr_accessor :change
      
      # @return [String] duration of change value
      attr_accessor :change_duration
      
      # @return [String] percentile
      attr_accessor :percentile
      
      # @return [Hash] local real estate links (values: URL strings, keys: :overview, :for_sale_by_owner, :for_sale)
      #
      # @example
      #    puts local_real_estate[:overview]
      #
      attr_accessor :local_real_estate
      
      # @return [String] region name
      attr_accessor :region
      
      # @return [String] region id
      attr_accessor :region_id
      
      # @return [String] region type
      attr_accessor :region_type
      
      protected
      
      # @private
      def extract_zestimate(xml)
        extract_zpid(xml)
        extract_links(xml)
        extract_address(xml)
        
        @price = xml.xpath('//zestimate/amount').text
        @last_updated = Date.strptime(xml.xpath('//zestimate/last-updated').text, "%m/%d/%Y")
        @valuation_range = {
          :low  => xml.xpath('//zestimate/valuationRange/low').text,
          :high => xml.xpath('//zestimate/valuationRange/high').text,
        }
        @change = xml.xpath('//zestimate/valueChange').text
        @change_duration = xml.xpath('//zestimate/valueChange').attr('duration').value
        @percentile = xml.xpath('//zestimate/percentile').text
        
        @region = xml.xpath('//localRealEstate/region').attribute('name').value
        @region_id = xml.xpath('//localRealEstate/region').attribute('id').value
        @region_type = xml.xpath('//localRealEstate/region').attribute('type').value
      
        @local_real_estate = {
          :overview => xml.xpath('//localRealEstate/region/links/overview').text,
          :for_sale_by_owner => xml.xpath('//localRealEstate/region/links/forSaleByOwner').text,
          :for_sale => xml.xpath('//localRealEstate/region/links/forSale').text,
        }
      end
    end
  end
end