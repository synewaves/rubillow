require "spec_helper"

describe Rubillow::Models::UpdatedPropertyDetails do
  it "populates the data" do
    data = Rubillow::Models::UpdatedPropertyDetails.new(get_xml('get_updated_property_details.xml'))

    data.zpid.should == '48749425'
    data.links.count.should == 3
    data.links[:homeDetails].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"
    data.links[:photoGallery].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#image=lightbox%3Dtrue"
    data.links[:homeInfo].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"
    data.address[:street].should == "2114 Bigelow Ave N"
    data.address[:city].should == "Seattle"
    data.address[:state].should == "WA"
    data.address[:zipcode].should == "98109"
    data.address[:latitude].should == "47.637933"
    data.address[:longitude].should == "-122.347938"
    data.page_views[:current_month].should == "27"
    data.page_views[:total].should == "8095"
    data.neighborhood.should == "Queen Anne"
    data.school_district.should == "Seattle"
    data.elementary_school.should == "John Hay"
    data.middle_school.should == "McClure"
    data.home_description.should == "Bright, spacious, 4 bedroom/3 bath Craftsman, with stunning, expansive views, on one of Queen Anne's finest streets. Views of Lk Union, Lk Washington,the Cascades from Mt. Baker to Mt. Rainier, and the city-from two levels and 2 view decks. Craftsman charm intact: hardwood floors, cove moldings, crystal doorknobs, Batchelder tile fireplace. Huge gourmet eat-in kitchen with slab granite countertops, deluxe master suite, theater-like media room, level rear yard with garden space and covered patio."
    data.images_count.should == "17"
    data.images.count.should == 5
    data.images[0].should == "http://photos1.zillow.com/is/image/i0/i4/i3019/IS1d2piz9kupb4z.jpg?op_sharpen=1&qlt=90&hei=400&wid=400"
    data.images[1].should == "http://photos3.zillow.com/is/image/i0/i4/i3019/ISkzzhgcun7u03.jpg?op_sharpen=1&qlt=90&hei=400&wid=400"
    data.images[2].should == "http://photos2.zillow.com/is/image/i0/i4/i3019/ISkzzhg8wkzq1v.jpg?op_sharpen=1&qlt=90&hei=400&wid=400"
    data.images[3].should == "http://photos1.zillow.com/is/image/i0/i4/i3019/ISkzzhg4yirm3n.jpg?op_sharpen=1&qlt=90&hei=400&wid=400"
    data.images[4].should == "http://photos3.zillow.com/is/image/i0/i4/i3019/ISkzzhg10gji5f.jpg?op_sharpen=1&qlt=90&hei=400&wid=400"
    data.edited_facts[:use_code].should == "SingleFamily"
    data.edited_facts[:bedrooms].should == "4"
    data.edited_facts[:bathrooms].should == "3.0"
    data.edited_facts[:finished_sq_ft].should == "3470"
    data.edited_facts[:lot_size_sq_ft].should == "4680"
    data.edited_facts[:year_built].should == "1924"
    data.edited_facts[:year_updated].should == "2003"
    data.edited_facts[:num_floors].should == "2"
    data.edited_facts[:basement].should == "Finished"
    data.edited_facts[:roof].should == "Composition"
    data.edited_facts[:view].should == "Water, City, Mountain"
    data.edited_facts[:parking_type].should == "Off-street"
    data.edited_facts[:heating_sources].should == "Gas"
    data.edited_facts[:heating_system].should == "Forced air"
    data.edited_facts[:rooms].should == "Laundry room, Walk-in closet, Master bath, Office, Dining room, Family room, Breakfast nook"
  end
end
