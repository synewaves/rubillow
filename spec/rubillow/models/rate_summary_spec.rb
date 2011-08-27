require "spec_helper"

describe Rubillow::Models::RateSummary do
  it "populates the results" do
    data = Rubillow::Models::RateSummary.new(get_xml('get_rate_summary.xml'))
    
    data.today[:thiry_year_fixed].should == "4.01"
    data.today[:fifteen_year_fixed].should == "3.27"
    data.today[:five_one_arm].should == "2.73"
    data.last_week[:thiry_year_fixed].should == "4.02"
    data.last_week[:fifteen_year_fixed].should == "3.27"
    data.last_week[:five_one_arm].should == "2.84"
  end
end