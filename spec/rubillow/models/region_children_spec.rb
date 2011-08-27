require "spec_helper"

describe Rubillow::Models::RegionChildren do
  it "populates the data" do
    data = Rubillow::Models::RegionChildren.new(get_xml('get_region_children.xml'))
    
    data.region.id.should == "16037"
    data.regions.count.should == 107
    data.regions[0].id.should == "343997"
  end
end