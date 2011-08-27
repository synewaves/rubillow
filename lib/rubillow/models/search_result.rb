module Rubillow
  module Models
    # Property search results
    class SearchResult < Base
      include Zestimateable
      
      protected
      
      # @private
      def parse
        super
        
        return if !success?
        
        extract_zestimate(@parser)
      end
    end
  end
end