require "spec_helper"

describe Rubillow::PropertyDetails, ".deep_search_results" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the address option" do
    lambda {
      Rubillow::PropertyDetails.deep_search_results({ :citystatezip => 'Baton Rouge, LA, 70802' })
    }.should raise_error(ArgumentError, "The address option is required")
  end
  
  it "requires the citystatezip option" do
    lambda {
      Rubillow::PropertyDetails.deep_search_results({ :address => '100 North Blvd' })
    }.should raise_error(ArgumentError, "The citystatezip option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::PropertyDetails.deep_search_results({ :address => '2114 Bigelow Ave', :citystatezip => 'Seattle, WA' })
    response.should be_an_instance_of(Rubillow::Models::DeepSearchResult)
  end  
end

describe Rubillow::PropertyDetails, ".deep_comps" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the zpid option" do
    lambda {
      Rubillow::PropertyDetails.deep_comps()
    }.should raise_error(ArgumentError, "The zpid option is required")
  end
  
  it "requires the count option" do
    lambda {
      Rubillow::PropertyDetails.deep_comps({ :zpid => '48749425' })
    }.should raise_error(ArgumentError, "The count option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::PropertyDetails.deep_comps({ :zpid => '48749425', :count => 5 })
    response.should be_an_instance_of(Rubillow::Models::DeepComps)
  end
end

describe Rubillow::PropertyDetails, ".updated_property_details" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the zpid option" do
    lambda {
      Rubillow::PropertyDetails.updated_property_details()
    }.should raise_error(ArgumentError, "The zpid option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::PropertyDetails.updated_property_details({ :zpid => '48749425' })
    response.should be_an_instance_of(Rubillow::Models::UpdatedPropertyDetails)
  end
end