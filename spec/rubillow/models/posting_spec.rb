require "spec_helper"

describe Rubillow::Models::Posting do
  it "populates the data" do
    data = Rubillow::Models::Postings.new(get_xml('get_region_postings.xml'))
    data = data.make_me_move[0]
    
    data.should be_a(Rubillow::Models::Posting)
    data.zpid.should == "48708109"
    data.last_refreshed_date.strftime("%m/%d/%Y").should == "08/21/2011"
    data.links.count.should == 1
    data.links[:homedetails].should == "http://www.zillow.com/homedetails/1658-Federal-Ave-E-Seattle-WA-98102/48708109_zpid/"
    data.address[:street].should == "1658 Federal Ave E"
    data.address[:city].should == "Seattle"
    data.address[:state].should == "WA"
    data.address[:zipcode].should == "98102"
    data.address[:latitude].should == "47.634532"
    data.address[:longitude].should == "-122.318519"
    data.use_code.should == "Single Family"
    data.lot_size_square_feet.should == "20000"
    data.finished_square_feet.should == "7380"
    data.bathrooms.should == "5.0"
    data.bedrooms.should == "6"
    data.total_rooms.should == ""
    data.images_count.should == "1"
    data.price.should == "4500000"
  end
end