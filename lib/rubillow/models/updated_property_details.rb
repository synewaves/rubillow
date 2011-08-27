module Rubillow
  module Models
    class UpdatedPropertyDetails < Base
      include Zpidable
      include Addressable
      include Linkable
      include Images
      
      attr_accessor :page_views
      attr_accessor :price
      attr_accessor :neighborhood
      attr_accessor :elementary_school
      attr_accessor :middle_school
      attr_accessor :school_district
      attr_accessor :home_description
      attr_accessor :posting
      attr_accessor :edited_facts
      
      protected
      
      def parse
        super
        
        return if !success?
        
        extract_zpid(@parser)
        extract_links(@parser)
        extract_address(@parser)
        extract_images(@parser)
        
        @page_views = {
          :current_month => @parser.xpath('//pageViewCount/currentMonth').text,
          :total => @parser.xpath('//pageViewCount/total').text
        }
        @price = @parser.xpath('//price').text
        @neighborhood = @parser.xpath('//neighborhood').text
        @school_district = @parser.xpath('//schoolDistrict').text
        @elementary_school = @parser.xpath('//elementarySchool').text
        @middle_school = @parser.xpath('//middleSchool').text
        @home_description = @parser.xpath('//homeDescription').text
        
        @posting = {}
        @parser.xpath('//posting').children.each do |elm|
          @posting[elm.name.underscore.to_sym] = elm.text
        end
        
        @edited_facts = {}
        @parser.xpath('//editedFacts').children.each do |elm|
          @edited_facts[elm.name.underscore.to_sym] = elm.text
        end
      end
    end
  end
end