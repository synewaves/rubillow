module Rubillow
  module Models
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
  end
end