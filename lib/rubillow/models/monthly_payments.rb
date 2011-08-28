module Rubillow
  module Models
    # Monthly payment information
    class MonthlyPayments < Base
      # @return [Hash] 30 year fixed rate data (:rate, :principal_and_interest, :mortgage_insurance).
      #
      # @example
      #   puts thirty_year_fixed[:rate]
      #
      attr_accessor :thirty_year_fixed
      
      # @return [Hash] 15 year fixed rate data (:rate, :principal_and_interest, :mortgage_insurance).
      #
      # @example
      #   puts fifteen_year_fixed[:rate]
      #
      attr_accessor :fifteen_year_fixed
      
      # @return [Hash] 5/1 fixed rate data (:rate, :principal_and_interest, :mortgage_insurance).
      #
      # @example
      #   puts five_one_arm[:rate]
      #
      attr_accessor :five_one_arm
      
      # @return [String] down payment amount.
      attr_accessor :down_payment
      
      # @return [String] monthly property taxes (estimated).
      attr_accessor :monthly_property_taxes
      
      # @return [String] monthyly hazard insurance (estimated).
      attr_accessor :monthly_hazard_insurance
      
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        @thirty_year_fixed = {
          :rate => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/monthlyPrincipalAndInterest').text,
          :mortgage_insurance => @parser.xpath('//payment[@loanType="thirtyYearFixed"]/monthlyMortgageInsurance').text,
        }
        @fifteen_year_fixed = {
          :rate => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/monthlyPrincipalAndInterest').text,
          :mortgage_insurance => @parser.xpath('//payment[@loanType="fifteenYearFixed"]/monthlyMortgageInsurance').text,
        }
        @five_one_arm = {
          :rate => @parser.xpath('//payment[@loanType="fiveOneARM"]/rate').text,
          :principal_and_interest => @parser.xpath('//payment[@loanType="fiveOneARM"]/monthlyPrincipalAndInterest').text,
          :mortgage_insurance => @parser.xpath('//payment[@loanType="fiveOneARM"]/monthlyMortgageInsurance').text,
        }
        @down_payment = @parser.xpath('//downPayment').text
        @monthly_property_taxes = @parser.xpath('//monthlyPropertyTaxes').text
        @monthly_hazard_insurance = @parser.xpath('//monthlyHazardInsurance').text
      end
    end
  end
end