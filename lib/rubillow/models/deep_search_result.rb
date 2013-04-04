module Rubillow
  module Models
    # Get a property's information with deeper data.
    class DeepSearchResult < SearchResult    
      include PropertyBasics
      
      # @return [String] FIPS county code. See {http://www.itl.nist.gov/fipspubs/fip6-4.htm}.
      attr_accessor :fips_county
      
      # @return [String] year of the last tax assessment
      attr_accessor :tax_assessment_year
      
      # @return [String] value of the last tax assessment
      attr_accessor :tax_assessment
      
      # @return [String] year home was built
      attr_accessor :year_built
      
      # @return [Date] last date property was sold
      attr_accessor :last_sold_date
      
      # @return [String] price property was last sold for
      attr_accessor :last_sold_price
      
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        extract_property_basics(@parser)
        @fips_county = ""
        @fips_county = @parser.xpath('//FIPScounty').first.text unless @parser.xpath('//FIPScounty').empty?
        @tax_assessment_year = @parser.xpath('//taxAssessmentYear').first.text
        @tax_assessment = @parser.xpath('//taxAssessment').first.text
        @year_built = @parser.xpath('//yearBuilt').first.text
        if tmp = @parser.xpath('//lastSoldDate').first.text and tmp.strip.length > 0
          @last_sold_date = Date.strptime(tmp, "%m/%d/%Y")
        end
        @last_sold_price = @parser.xpath('//lastSoldPrice').first.text
      end
    end
  end
end