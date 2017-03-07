module Rubillow
  module Models
    # List of updated attributes for a property.
    class UpdatedPropertyDetails < Base
      include Zpidable
      include Addressable
      include Linkable
      include Images

      # @return [Hash] number of page views (:current_month, :total).
      #
      # @example
      #   puts page_views[:current_month]
      #
      attr_accessor :page_views

      # @return [String] price.
      attr_accessor :price

      # @return [String] neighborhood.
      attr_accessor :neighborhood

      # @return [String] elementary school's name.
      attr_accessor :elementary_school

      # @return [String] middle school's name.
      attr_accessor :middle_school

      # @return [String] school district's name.
      attr_accessor :school_district

      # @return [String] Realtor provided home description
      attr_accessor :home_description

      # @return [Hash] posting information
      #
      # @example
      #   posting.each do |key, value|
      #   end
      #
      attr_accessor :posting

      # @return [Hash] list of edited facts
      #
      # @example
      #   edited_facts.each do |key, value|
      #   end
      #
      attr_accessor :edited_facts

      protected

      # @private
      def parse
        super

        return if !success?

        extract_zpid(@parser)
        extract_links(@parser)
        extract_address(@parser)
        extract_images(@parser)

        @page_views = {
          :current_month => @parser.xpath('//pageViewCount/currentMonth').first.text,
          :total => @parser.xpath('//pageViewCount/total').first.text
        }

        if !@parser.xpath('//neighborhood').empty?
          @neighborhood = @parser.xpath('//neighborhood').first.text
        end
        if !@parser.xpath('//schoolDistrict').empty?
          @school_district = @parser.xpath('//schoolDistrict').first.text
        end
        if !@parser.xpath('//elementarySchool').empty?
          @elementary_school = @parser.xpath('//elementarySchool').first.text
        end
        if !@parser.xpath('//middleSchool').empty?
          @middle_school = @parser.xpath('//middleSchool').first.text
        end
        if !@parser.xpath('//highSchool').empty?
          @high_school = @parser.xpath('//highSchool').first.text
        end
        if !@parser.xpath('//homeDescription').empty?
          @home_description = @parser.xpath('//homeDescription').first.text
        end

        if !@parser.xpath('//posting').empty?
          @posting = {}
          @parser.xpath('//posting').children.each do |elm|
            @posting[underscore(elm.name).to_sym] = elm.text
          end
        end

        if(@parser.xpath('//editedFacts'))
          @edited_facts = {}
          @parser.xpath('//editedFacts').children.each do |elm|
            @edited_facts[underscore(elm.name).to_sym] = elm.text
          end
        end
      end

      # @private
      def underscore(string)
        word = string.to_s.dup
        word.gsub!(/::/, '/')
        word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.gsub!(/\-/, '_')
        word.downcase!
        word
      end
    end
  end
end
