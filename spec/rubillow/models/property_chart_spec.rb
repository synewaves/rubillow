require "spec_helper"

describe Rubillow::Models::PropertyChart do
  it "populates the results" do
    data = Rubillow::Models::PropertyChart.new(get_xml('get_chart.xml'))
    
    data.width.should == 300
    data.height.should == 150
    data.url.should == "http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425"
    data.graphs_and_data.should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data"
  end
  
  it "should format correctly for HTML" do
    data = Rubillow::Models::PropertyChart.new(get_xml('get_chart.xml'))
    
    data.to_html.should == "<a href='http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data'><img src='http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425' height='150' width='300' /></a>"
  end
end