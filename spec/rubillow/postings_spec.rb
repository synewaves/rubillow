require "spec_helper"

describe Rubillow::Postings, ".region_postings" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires either the zipcode or citystatezip option" do
    lambda {
      Rubillow::Postings.region_postings()
    }.should raise_error(ArgumentError, "Either the zipcode or citystatezip option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::Postings.region_postings({ :zipcode => "98102", :rental => true })
    response.should be_an_instance_of(Rubillow::Models::Postings)
  end
end