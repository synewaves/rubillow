require "nokogiri"
require "active_support/core_ext/string"
require "active_support/inflector"

module Rubillow
  module Models
    # 
    class Base
      attr_accessor :xml
      attr_accessor :parser
      attr_accessor :message
      attr_accessor :code
      attr_accessor :near_limit
    
      def initialize(xml)
        if !xml.blank?
          @xml = xml
          @parser = Nokogiri::XML(xml) { |cfg| cfg.noblanks }
          parse
        end
      end
    
      def success?
        @code.to_i == 0
      end
    
      protected
      
      def parse
        @message = @parser.xpath('//message/text').text
        @code = @parser.xpath('//message/code').text.to_i
        
        limit = @parser.xpath('//message/limit-warning')
        @near_limit = !limit.empty? && limit.text.downcase == "true"
      end
    end
    
    #
    module Zpidable
      attr_accessor :zpid
      
      protected
      
      def extract_zpid(xml)
        # TODO: clean up this logic
        if !xml.xpath('//response/zpid').empty?
          selector = '//response/zpid'
        elsif !xml.xpath('//result/zpid').empty?
          selector = '//result/zpid'
        else
          selector = '//zpid'
        end
        
        @zpid = xml.xpath(selector).text
      end
    end
    
    #
    module Linkable
      attr_accessor :links
      
      protected
      
      def extract_links(xml)
        @links = {}
        
        # TODO: clean up this logic
        if !xml.xpath('//result/links').empty?
          selector = '//result/links'
        elsif !xml.xpath('//response/links').empty?
          selector = '//response/links'
        elsif !xml.xpath('//principal/links').empty?
          selector = '//principal/links'
        elsif !xml.xpath('//comp/links').empty?
          selector = '//comp/links'
        else
          selector = '//links'
        end
        
        xml.xpath(selector).children.each do |link|
          next if link.name == "myzestimator" # deprecated
          @links[link.name.to_sym] = link.text
        end
      end
    end
    
    #
    module Addressable
      attr_accessor :address
      
      protected
      
      def extract_address(xml)
        address = xml.xpath('//address')
        if !address.empty?
          @address = {
            :street    => address.xpath('//street').text,
            :city      => address.xpath('//city').text,
            :state     => address.xpath('//state').text,
            :zipcode   => address.xpath('//zipcode').text,
            :latitude  => address.xpath('//latitude').text,
            :longitude => address.xpath('//longitude').text,
          }
        end
      end
    end
    
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
    
    # 
    class SearchResult < Base
      include Zestimateable
      
      protected
      
      def parse
        super
        
        return if !success?
        
        extract_zestimate(@parser)
      end
    end
    
    # 
    class Chart < Base
      attr_accessor :height
      attr_accessor :width
      attr_accessor :url
      attr_accessor :graphs_and_data
      
      def to_html
        "<a href='#{@graphs_and_data}'><img src='#{@url}' height='#{@height}' width='#{width}' /></a>"
      end
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @height = @parser.xpath('//request/height').text.to_i
        @width = @parser.xpath('//request/width').text.to_i
        @url = @parser.xpath('//response/url').text
        @graphs_and_data = @parser.xpath('//response/graphsanddata').text
      end
    end
    
    # 
    class Comps < Base
      attr_accessor :principal
      attr_accessor :comparables
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @principal = SearchResult.new(@parser.xpath('//principal').to_xml)
        
        @comparables = {}
        @parser.xpath('//comparables/comp').each do |elm|
          key = elm.attribute('score').value
          @comparables[key] = SearchResult.new(elm.to_xml)
        end
      end
    end
    
    #
    class RateSummary < Base
      attr_accessor :today
      attr_accessor :last_week
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @today = {}
        @last_week = {}
        @today[:thiry_year_fixed] = @parser.xpath('//today/rate[@loanType="thirtyYearFixed"]').text
        @today[:fifteen_year_fixed] = @parser.xpath('//today/rate[@loanType="fifteenYearFixed"]').text
        @today[:five_one_arm] = @parser.xpath('//today/rate[@loanType="fiveOneARM"]').text
        @last_week[:thiry_year_fixed] = @parser.xpath('//lastWeek/rate[@loanType="thirtyYearFixed"]').text
        @last_week[:fifteen_year_fixed] = @parser.xpath('//lastWeek/rate[@loanType="fifteenYearFixed"]').text
        @last_week[:five_one_arm] = @parser.xpath('//lastWeek/rate[@loanType="fiveOneARM"]').text
      end
    end
    
    #
    class MonthlyPayments < Base
      attr_accessor :thirty_year_fixed
      attr_accessor :fifteen_year_fixed
      attr_accessor :five_one_arm
      attr_accessor :down_payment
      attr_accessor :monthly_property_taxes
      attr_accessor :monthly_hazard_insurance
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @thirty_year_fixed = {
          :rate => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/monthlyPrincipalAndInterest').text,
          :insurance => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/monthlyMortgageInsurance').text,
        }
        @fifteen_year_fixed = {
          :rate => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/monthlyPrincipalAndInterest').text,
          :insurance => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/monthlyMortgageInsurance').text,
        }
        @five_one_arm = {
          :rate => @parser.xpath('//payment[@loanType="fiveOneARM"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="fiveOneARM"]/monthlyPrincipalAndInterest').text,
          :insurance => @parser.xpath('//payment[@loanType="fiveOneARM"]/monthlyMortgageInsurance').text,
        }
        @down_payment = @parser.xpath('//downPayment').text
        @monthly_property_taxes = @parser.xpath('//monthlyPropertyTaxes').text
        @monthly_hazard_insurance = @parser.xpath('//monthlyHazardInsurance').text
      end
    end
    
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
    
    #
    module PropertyBasics
      attr_accessor :use_code
      attr_accessor :lot_size_square_feet
      attr_accessor :finished_square_feet
      attr_accessor :bathrooms
      attr_accessor :bedrooms
      attr_accessor :total_rooms
      
      protected
      
      def extract_property_basics(xml)
        @use_code = xml.xpath('//useCode').text
        @lot_size_square_feet = xml.xpath('//lotSizeSqFt').text
        @finished_square_feet = xml.xpath('//finishedSqFt').text
        @bathrooms = xml.xpath('//bathrooms').text
        @bedrooms = xml.xpath('//bedrooms').text
        @total_rooms = xml.xpath('//totalRooms').text
      end
    end
    
    # 
    module Images
      attr_accessor :images
      attr_accessor :images_count
      
      protected
      
      def extract_images(xml)
        @images_count = xml.xpath('//images/count').text
        
        @images = []
        xml.xpath('//images/image').children.each do |elm|
          @images << elm.text
        end
      end
    end
    
    # 
    class Posting < Base
      include Zpidable
      include Addressable
      include Linkable
      include PropertyBasics
      include Images
      
      attr_accessor :last_refreshed_date
      attr_accessor :images_count
      attr_accessor :price
      
      protected
      
      def parse
        super
        
        return if !success?
        
        property = @parser.xpath('//property').first
        extract_zpid(property)
        extract_links(property)
        extract_address(property)
        extract_property_basics(property)
        extract_images(property)
        
        @last_refreshed_date = Date.strptime(@parser.xpath('//lastRefreshedDate').text, "%Y-%m-%d")
        @price = @parser.xpath('//price').text
      end
    end
    
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
    
    # 
    class DeepComps < Base
      attr_accessor :principal
      attr_accessor :comparables
      
      protected
      
      def parse
        super
        
        return if !success?
        
        @principal = DeepSearchResult.new(@parser.xpath('//principal').to_xml)
        
        @comparables = {}
        @parser.xpath('//comparables/comp').each do |elm|
          key = elm.attribute('score').value
          @comparables[key] = DeepSearchResult.new(elm.to_xml)
        end
      end
    end
    
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