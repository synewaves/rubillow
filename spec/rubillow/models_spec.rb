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
  
  it "fails if empty XML" do
    data = Rubillow::Models::Base.new("")
    
    data.success?.should be_false
    data.code.should == -1
    data.message.should == "Error connecting to remote service."
  end
  
  it "fails if nil XML" do
    data = Rubillow::Models::Base.new(nil)
    
    data.success?.should be_false
    data.code.should == -1
    data.message.should == "Error connecting to remote service."
  end
  
  it "fails if passed false" do
    data = Rubillow::Models::Base.new(false)
    
    data.success?.should be_false
    data.code.should == -1
    data.message.should == "Error connecting to remote service."
  end
  
  it "saves raw XML" do
    data = Rubillow::Models::Base.new(get_xml('near_limit.xml'))
    
    data.xml.should == get_xml('near_limit.xml')
  end
end