module Rubillow
  module Models
    # 
    module Zestimateable
      include Zpidable
      include Addressable
      include Linkable
      
      attr_accessor :zpid
      attr_accessor :price
      attr_accessor :last_updated
      attr_accessor :valuation_range
      attr_accessor :change
      attr_accessor :change_duration
      attr_accessor :percentile
      attr_accessor :local_real_estate
      attr_accessor :region
      attr_accessor :region_id
      attr_accessor :region_type
      
      protected
      
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