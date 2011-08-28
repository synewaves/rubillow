require "spec_helper"

describe Rubillow::Models::Demographics do
  it "populates the data" do
    data = Rubillow::Models::Demographics.new(get_xml('get_demographics.xml'))
    
    data.region.id.should == "250017"
    data.region.state.should == "Washington"
    data.region.neighborhood.should == "Ballard"
    data.region.latitude.should == "47.668329"
    data.region.longitude.should == "-122.384536"
    data.region.zmmrateurl.should == "http://www.zillow.com/mortgage-rates/wa/seattle/"
    
    data.links.count.should == 8
    
    data.charts.count.should == 6  
    data.charts['Median Condo Value'].should == "http://www.zillow.com/app?chartType=affordability_avgCondoValue&graphType=barChart&regionId=250017&regionType=8&service=chart"
    
    data.affordability_data.count.should == 20
    data.affordability_data['Zillow Home Value Index'][:neighborhood].value.should == "305200"
    data.affordability_data['Zillow Home Value Index'][:neighborhood].type.should == "USD"
    data.affordability_data['Median Single Family Home Value'][:city].value.should == "377000"
    data.affordability_data['Median Condo Value'][:nation].value.should == "155800"
    
    data.census_data.count.should == 7
    data.census_data['HomeSize']['<1000sqft'].value.should == "0.3922527265889"
    data.census_data['HomeSize']['<1000sqft'].type.should == "percent"
    data.census_data['HomeSize']['1800-2400sqft'].value.should == "0.0699511094396"
    data.census_data['HomeType']['Other'].value.should == "1.9343463444890998"
    data.census_data['HomeType']['SingleFamily'].value.should == "0.1712158808933"
    data.census_data['Occupancy']['Rent'].value.should == "0.64971382"
    data.census_data['Occupancy']['Rent'].type.should == "percent"
    data.census_data['AgeDecade']['40s'].value.should == "0.159760457231474"
    data.census_data['AgeDecade']['40s'].type.should == "percent"
    data.census_data['Household']['NoKids'].value.should == "0.850066140827795"
    data.census_data['Household']['NoKids'].type.should == "percent"
    
    data.metrics.count.should == 3
    data.metrics['BuiltYear']['<1900'].value.should == "0.0419354838709"
    data.metrics['BuiltYear']['<1900'].to_s.should == "0.0419354838709"
    data.metrics['BuiltYear']['<1900'].type.should == "percent"
    data.metrics['BuiltYear']['1940-1959'].value.should == "0.0537634408602"
    data.metrics['BuiltYear']['1940-1959'].type.should == "percent"
    data.metrics['People Data']['Median Household Income'][:neighborhood].value.should == "41202.9453206937"
    data.metrics['People Data']['Single Females'][:city].value.should == "0.187486853578992"
    data.metrics['People Data']['Average Commute Time (Minutes)'][:nation].value.should == "26.375545725891282"
    
    data.segmentation.count.should == 3
    data.segmentation["Makin' It Singles"][:name].should == "Upper-scale urban singles."
    data.segmentation["Makin' It Singles"][:description].should == "Pre-middle-age to middle-age singles with upper-scale incomes. May or may not own their own home. Most have college educations and are employed in mid-management professions."
    data.segmentation['Aspiring Urbanites'][:name].should == "Urban singles with moderate income."
    data.segmentation['Aspiring Urbanites'][:description].should == "Low- to middle-income singles over a wide age range. Some have a college education. They work in a variety of occupations, including some management-level positions."
    
    data.characteristics.count.should == 4
    data.characteristics['Education'].should include("Bachelor's degrees")
    data.characteristics['Employment'].should include("Work in office and administrative support occupations")
    data.characteristics['People & Culture'].should include("Divorced females")
    data.characteristics['Transportation'].should include("Get to work by bus")
  end
end