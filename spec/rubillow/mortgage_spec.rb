require "spec_helper"

describe Rubillow::Mortgage, ".rate_summary" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::Mortgage.rate_summary()
    response.should be_an_instance_of(Rubillow::Models::RateSummary)
  end
end

describe Rubillow::Mortgage, ".monthly_payments" do
  let(:request)  { stub("Request", :get => response) }
  let(:response) { stub("Response", :body => "", :code => 200) }
  
  it "requires the price option" do
    lambda {
      Rubillow::Mortgage.monthly_payments()
    }.should raise_error(ArgumentError, "The price option is required")
  end
  
  it "requires either the down or dollars down option" do
    lambda {
      Rubillow::Mortgage.monthly_payments({ :price => "300000" })
    }.should raise_error(ArgumentError, "Either the down or dollarsdown option is required")
  end
  
  it "fetches the XML" do
    Rubillow::Request.stub(:request).and_return(request)
    
    response = Rubillow::Mortgage.monthly_payments({ :price => "300000", :down => "15", :zip => "98104" })
    response.should be_an_instance_of(Rubillow::Models::MonthlyPayments)
  end
end