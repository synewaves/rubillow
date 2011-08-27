module Rubillow
  module Models
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
  end
end