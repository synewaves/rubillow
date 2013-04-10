module Rubillow
  module Models
    # Get a property's information with deeper data.
    class DeepSearchResult < SearchResult    
      include PropertyBasics
      include XmlParsingHelper
      
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
        @fips_county = xpath_if_present('//FIPScounty', :text, @parser, "")
        @tax_assessment_year = xpath_if_present('//taxAssessmentYear', :text, @parser)
        @tax_assessment = xpath_if_present('//taxAssessment', :text, @parser)
        @year_built = xpath_if_present('//yearBuilt', :text, @parser)
        if tmp = xpath_if_present('//lastSoldDate', :text, @parser) and tmp.strip.length > 0
          @last_sold_date = Date.strptime(tmp, "%m/%d/%Y")
        end
        @last_sold_price = xpath_if_present('//lastSoldPrice', :text, @parser)
      end
    end
  end
end
