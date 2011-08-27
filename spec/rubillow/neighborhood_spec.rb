require "spec_helper"

describe Rubillow::Neighborhood, ".demographics" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires either the regionid, state and city, city and neighborhood, or zip option" do
    lambda {
      Rubillow::Neighborhood.demographics()
    }.should raise_error(ArgumentError, "The regionid, state and city, city and neighborhood or zip option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stubs(:request).returns(request)
    
    response = Rubillow::Neighborhood.demographics({ :state => 'WA', :city => 'Seattle', :neighborhood => 'Ballard' })
    response.should be_an_instance_of(Rubillow::Models::Demographics)
  end  
end

describe Rubillow::Neighborhood, ".region_children" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires either the regionid or state option" do
    lambda {
      Rubillow::Neighborhood.region_children()
    }.should raise_error(ArgumentError, "The regionid or state option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stubs(:request).returns(request)
    
    response = Rubillow::Neighborhood.region_children({ :state => 'WA', :city => 'Seattle', :childtype => 'neighborhood' })
    response.should be_an_instance_of(Rubillow::Models::RegionChildren)
  end  
end

describe Rubillow::Neighborhood, ".region_chart" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the unit_type option" do
    lambda {
      Rubillow::Neighborhood.region_chart()
    }.should raise_error(ArgumentError, "The unit_type option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stubs(:request).returns(request)
    
    response = Rubillow::Neighborhood.region_chart({ :city => 'Seattle', :state => 'WA', :unit_type => 'percent', :width => 300, :height => 150 })
    response.should be_an_instance_of(Rubillow::Models::RegionChart)
  end  
end