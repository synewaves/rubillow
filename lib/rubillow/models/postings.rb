module Rubillow
  module Models
    # List of postings 
    class Postings < Base
      include Linkable
      
      # @return [String] region id.
      attr_accessor :region_id
      
      # @return [Array] postings with MakeMeMove status ({Models::Posting}).
      attr_accessor :make_me_move
      
      # @return [Array] postings with FSBA status ({Models::Posting}).
      attr_accessor :for_sale_by_owner
      
      # @return [Array] postings with FSBO status ({Models::Posting}).
      attr_accessor :for_sale_by_agent
      
      # @return [Array] postings with reporting status ({Models::Posting}).
      attr_accessor :report_for_sale
      
      # @return [Array] postings with for rent status ({Models::Posting}).
      attr_accessor :for_rent
      
      protected
      
      # @private
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