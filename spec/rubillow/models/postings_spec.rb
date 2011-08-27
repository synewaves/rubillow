require "spec_helper"

describe Rubillow::Models::Postings do
  it "populates the data" do
    data = Rubillow::Models::Postings.new(get_xml('get_region_postings.xml'))
    
    data.region_id.should == "99562"
    data.links.count.should == 3
    data.make_me_move.count.should == 90
    data.for_sale_by_owner.count.should == 1
    data.for_sale_by_agent.count.should == 8
    data.report_for_sale.count.should == 1
    data.for_rent.count.should == 1
  end
end