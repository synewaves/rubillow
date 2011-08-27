module Rubillow
  module Models
    class Demographics < Base
      include Linkable
      
      attr_accessor :region
      attr_accessor :charts
      attr_accessor :metrics
      attr_accessor :affordability_data
      attr_accessor :census_data
      attr_accessor :segmentation
      attr_accessor :characteristics
      
      protected
      
      def parse
        super
        
        return if !success?
        
        extract_links(@parser)
        
        @region = Region.new(@parser.xpath('//region').to_xml)
        
        @charts = {}
        @parser.xpath('//charts').children.each do |elm|
          if elm.xpath('name').attribute('deprecated').nil?
            @charts[elm.xpath('name').text] = elm.xpath('url').text
          end
        end
        
        @metrics = {}
        @affordability_data = {}
        @census_data = {}
        @segmentation = {}
        @characteristics = {}
        
        @parser.xpath('//pages').children.each do |page|
          page.xpath('tables').children.each do |table|
            table_name = table.xpath('name').text
            
            if table_name == "Affordability Data" && table.parent.parent.xpath('name').text == "Affordability"
              extract_affordability_data(table)
            elsif table_name[0,14] == "Census Summary"
              extract_census_data(table, table_name[15, table_name.length])
            else
              extract_data(table, table_name)
            end
          end
        end
        
        @parser.xpath('//segmentation').children.each do |segment|
          @segmentation[segment.xpath('title').text] = {
            :name => segment.xpath('name').text,
            :description => segment.xpath('description').text,
          }
        end
        
        @parser.xpath('//uniqueness').children.each do |category|
          key = category.attribute('type').text
          @characteristics[key] = []
          category.xpath('characteristic').each do |c|
            @characteristics[key] << c.text
          end
        end
      end
      
      def extract_affordability_data(xml)
        xml.xpath('data').children.each do |data|
          @affordability_data[data.xpath('name').text] = extract_metrics(data)
        end
      end
      
      def extract_census_data(xml, type)
        @census_data[type] = {}
        
        xml.xpath('data').children.each do |data|
          @census_data[type][data.xpath('name').text] = extract_metrics(data)
        end
      end
      
      def extract_data(xml, type)
        if @metrics[type].nil?
          @metrics[type] = {}
        end
        
        xml.xpath('data').children.each do |data|
          @metrics[type][data.xpath('name').text] = extract_metrics(data)
        end
      end
      
      def extract_metrics(xml)
        if xml.xpath('values').empty?
          DemographicValue.new(xml.xpath('value'))
        else
          {
            :neighborhood => DemographicValue.new(xml.xpath('values/neighborhood/value')),
            :city => DemographicValue.new(xml.xpath('values/city/value')),
            :nation => DemographicValue.new(xml.xpath('values/nation/value')),
            :zip => DemographicValue.new(xml.xpath('values/zip/value')),
          }
        end
      end
    end
  end
end