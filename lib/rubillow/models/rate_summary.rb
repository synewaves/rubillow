module Rubillow
  module Models
    # Rate summary information
    class RateSummary < Base
      # @return [Hash] today's rates (:thirty_year_fixed, :fifteen_year_fixed, :five_one_arm).
      #
      # @example
      #   today[:thirty_year_fixed]
      #
      attr_accessor :today
      
      # @return [Hash] last week's rates (:thirty_year_fixed, :fifteen_year_fixed, :five_one_arm).
      #
      # @example
      #   last_week[:thirty_year_fixed]
      #
      attr_accessor :last_week
      
      protected
      
      # @private
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
  end
end