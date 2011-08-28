require "spec_helper"

describe Rubillow::Models::MonthlyPayments do
  it "populates the results" do
    data = Rubillow::Models::MonthlyPayments.new(get_xml('get_monthly_payments.xml'))
    
    data.thirty_year_fixed[:rate].should == "4.01"
    data.thirty_year_fixed[:principal_and_interest].should == "1219"
    data.thirty_year_fixed[:mortgage_insurance].should == "93"
    data.fifteen_year_fixed[:rate].should == "3.27"
    data.fifteen_year_fixed[:principal_and_interest].should == "1795"
    data.fifteen_year_fixed[:mortgage_insurance].should == "93"
    data.five_one_arm[:rate].should == "3.27"
    data.five_one_arm[:principal_and_interest].should == "1039"
    data.five_one_arm[:mortgage_insurance].should == "93"
    data.down_payment.should == "45000"
    data.monthly_property_taxes.should == "193"
    data.monthly_hazard_insurance == "50"
  end
end