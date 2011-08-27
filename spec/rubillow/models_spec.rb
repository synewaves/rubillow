require "spec_helper"

describe Rubillow::Models::Base do
  it "catches error responses" do
    data = Rubillow::Models::Base.new(get_xml('general_failure.xml'))
    
    data.code.should == 2
    data.message.should == "Error: invalid or missing ZWSID parameter"
  end
  
  it "catches near limit warning" do
    data = Rubillow::Models::Base.new(get_xml('near_limit.xml'))
    
    data.near_limit.should be_true
  end
  
  it "doesn't parse if empty XML" do
    data = Rubillow::Models::Base.new(nil)
    
    data.code.should be_nil
    data.message.should be_nil
  end
  
  it "saves raw XML" do
    data = Rubillow::Models::Base.new(get_xml('near_limit.xml'))
    
    data.xml.should == get_xml('near_limit.xml')
  end
end