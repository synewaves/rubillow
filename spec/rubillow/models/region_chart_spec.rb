require "spec_helper"

describe Rubillow::Models::RegionChart do
  it "populates the results" do
    data = Rubillow::Models::RegionChart.new(get_xml('get_region_chart.xml'))
    
    data.width.should == 300
    data.height.should == 150
    data.url.should == "http://www.zillow.com/app?chartDuration=1year&chartType=partner&cityRegionId=16037&countyRegionId=0&height=150&nationRegionId=0&neighborhoodRegionId=0&page=webservice%2FGetRegionChart&service=chart&showCity=true&showPercent=true&stateRegionId=0&width=300&zipRegionId=0"
    data.link.should == "http://www.zillow.com/homes/Seattle-WA/"
    data.links.count.should == 3
  end
  
  it "should format correctly for HTML" do
    data = Rubillow::Models::RegionChart.new(get_xml('get_region_chart.xml'))
    
    data.to_html.should == "<a href='http://www.zillow.com/homes/Seattle-WA/'><img src='http://www.zillow.com/app?chartDuration=1year&chartType=partner&cityRegionId=16037&countyRegionId=0&height=150&nationRegionId=0&neighborhoodRegionId=0&page=webservice%2FGetRegionChart&service=chart&showCity=true&showPercent=true&stateRegionId=0&width=300&zipRegionId=0' height='150' width='300' /></a>"
  end
end