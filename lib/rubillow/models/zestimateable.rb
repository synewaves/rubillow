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

      # @return [Hash] Rent Zestimate information (keys: :price, :last_updated, :value_change, :value_duration, :valuation_range => { :low, :high }, :percentile)
      attr_accessor :rent_zestimate
      
      protected
      
      # @private
      def extract_zestimate(xml)
        extract_zpid(xml)
        extract_links(xml)
        extract_address(xml)
        
        @price = xml.xpath('//zestimate/amount').first.text
        @last_updated = Date.strptime(xml.xpath('//zestimate/last-updated').first.text, "%m/%d/%Y")
        @valuation_range = {
          :low  => xml.xpath('//zestimate/valuationRange/low').first.text,
          :high => xml.xpath('//zestimate/valuationRange/high').first.text,
        }
        @change = xml.xpath('//zestimate/valueChange').first.text
        if xml.xpath('//rentzestimate/amount').text.length > 0
          @rent_zestimate = {
            :price => xml.xpath('//rentzestimate/amount').first.text,
            :last_updated => xml.xpath('//rentzestimate/last-updated').first.text,
            :value_change => xml.xpath('//rentzestimate/valueChange').first.text,
            :value_duration => xml.xpath('//rentzestimate').first.xpath("//valueChange").first.attr("duration"),
            :valuation_range => {
              :low => xml.xpath('//rentzestimate/valuationRange/low').first.text,
              :high => xml.xpath('//rentzestimate/valuationRange/high').first.text
            },
            :percentile => xml.xpath('//rentzestimate/percentile').text
          }
        else
          @rent_zestimate = {}
        end

        if tmp = xml.xpath('//zestimate/valueChange').attr('duration')
          @change_duration = tmp.value
        end
        @percentile = xml.xpath('//zestimate/percentile').first.text

        if xml.at_xpath('//localRealEstate/region')
          @region = xml.xpath('//localRealEstate/region').attribute('name').value
          @region_id = xml.xpath('//localRealEstate/region').attribute('id').value
          @region_type = xml.xpath('//localRealEstate/region').attribute('type').value

          @local_real_estate = {
            :overview => xml.xpath('//localRealEstate/region/links/overview').first.text,
            :for_sale_by_owner => xml.xpath('//localRealEstate/region/links/forSaleByOwner').first.text,
            :for_sale => xml.xpath('//localRealEstate/region/links/forSale').first.text,
          }
        end
      end
    end
  end
end
