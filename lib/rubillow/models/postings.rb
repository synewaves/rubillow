module Rubillow
  module Models
    # 
    class Postings < Base
      include Linkable
      
      attr_accessor :region_id
      attr_accessor :make_me_move
      attr_accessor :for_sale_by_owner
      attr_accessor :for_sale_by_agent
      attr_accessor :report_for_sale
      attr_accessor :for_rent
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @region_id = @parser.xpath('//regionId').text
        
        extract_links(@parser)
        
        @make_me_move = []
        @parser.xpath('//response/makeMeMove/result').each do |elm|
          @make_me_move << Posting.new(elm.to_xml)
        end
        
        @for_sale_by_owner = []
        @parser.xpath('//response/forSaleByOwner/result').each do |elm|
          @for_sale_by_owner << Posting.new(elm.to_xml)
        end
        
        @for_sale_by_agent = []
        @parser.xpath('//response/forSaleByAgent/result').each do |elm|
          @for_sale_by_agent << Posting.new(elm.to_xml)
        end
        
        @report_for_sale = []
        @parser.xpath('//response/reportForSale/result').each do |elm|
          @report_for_sale << Posting.new(elm.to_xml)
        end
        
        @for_rent = []
        @parser.xpath('//response/forRent/result').each do |elm|
          @for_rent << Posting.new(elm.to_xml)
        end
      end
    end
  end
end