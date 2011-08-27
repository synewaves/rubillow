module Rubillow
  module Models
    #
    class DeepSearchResult < SearchResult    
      include PropertyBasics
      
      attr_accessor :fips_county
      attr_accessor :tax_assessment_year
      attr_accessor :tax_assessment
      attr_accessor :year_built
      attr_accessor :last_sold_date
      attr_accessor :last_sold_price
      
      def parse
        super
        
        return if !success?
        
        extract_property_basics(@parser)
        
        @fips_county = @parser.xpath('//FIPScounty').text
        @tax_assessment_year = @parser.xpath('//taxAssessmentYear').text
        @tax_assessment = @parser.xpath('//taxAssessment').text
        @year_built = @parser.xpath('//yearBuilt').text
        @last_sold_date = Date.strptime(@parser.xpath('//lastSoldDate').text, "%m/%d/%Y")
        @last_sold_price = @parser.xpath('//lastSoldPrice').text
      end
    end
  end
end