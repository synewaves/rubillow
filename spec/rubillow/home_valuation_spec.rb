require "spec_helper"

describe Rubillow::HomeValuation, ".search_results" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the address option" do
    lambda {
      Rubillow::HomeValuation.search_results({ :citystatezip => 'Seattle, WA' })
    }.should raise_error(ArgumentError, "The address option is required")
  end
  
  it "requires the citystatezip option" do
    lambda {
      Rubillow::HomeValuation.search_results({ :address => '2114 Bigelow Ave' })
    }.should raise_error(ArgumentError, "The citystatezip option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::HomeValuation.search_results({ :address => '2114 Bigelow Ave', :citystatezip => 'Seattle, WA' })
    response.should be_an_instance_of(Rubillow::Models::SearchResult)
  end  
end

describe Rubillow::HomeValuation, ".zestimate" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the zpid option" do
    lambda {
      Rubillow::HomeValuation.zestimate()
    }.should raise_error(ArgumentError, "The zpid option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::HomeValuation.zestimate({ :zpid => '48749425' })
    response.should be_an_instance_of(Rubillow::Models::SearchResult)
  end
end

describe Rubillow::HomeValuation, ".chart" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the zpid option" do
    lambda {
      Rubillow::HomeValuation.chart()
    }.should raise_error(ArgumentError, "The zpid option is required")
  end
  
  it "requires the unit_type option" do
    lambda {
      Rubillow::HomeValuation.chart({ :zpid => '48749425' })
    }.should raise_error(ArgumentError, "The unit_type option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::HomeValuation.chart({ :zpid => '48749425', :unit_type => "percent" })
    response.should be_an_instance_of(Rubillow::Models::PropertyChart)
  end
end

describe Rubillow::HomeValuation, ".comps" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the zpid option" do
    lambda {
      Rubillow::HomeValuation.comps()
    }.should raise_error(ArgumentError, "The zpid option is required")
  end
  
  it "requires the count option" do
    lambda {
      Rubillow::HomeValuation.comps({ :zpid => '48749425' })
    }.should raise_error(ArgumentError, "The count option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::HomeValuation.comps({ :zpid => '48749425', :count => 5 })
    response.should be_an_instance_of(Rubillow::Models::Comps)
  end
end