require "spec_helper"

describe Rubillow::Models::SearchResult do
  it "populates the results from GetSearchResults" do
    data = Rubillow::Models::SearchResult.new(get_xml('get_search_results.xml'))
    
    data.zpid.should == '48749425'
    data.links.count.should == 5
    data.links[:homedetails].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"
    data.links[:graphsanddata].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data"
    data.links[:mapthishome].should == "http://www.zillow.com/homes/48749425_zpid/"
    data.links[:myestimator].should == "http://www.zillow.com/myestimator/Edit.htm?zprop=48749425"
    data.links[:comparables].should == "http://www.zillow.com/homes/comps/48749425_zpid/"
    data.address[:street].should == "2114 Bigelow Ave N"
    data.address[:city].should == "Seattle"
    data.address[:state].should == "WA"
    data.address[:zipcode].should == "98109"
    data.address[:latitude].should == "47.637933"
    data.address[:longitude].should == "-122.347938"
    data.full_address.should == "2114 Bigelow Ave N, Seattle, WA 98109"
    data.price.should == "1032000"
    data.percentile.should == "0"
    data.last_updated.strftime("%m/%d/%Y").should == "08/24/2011"
    data.valuation_range[:low].should == "866880"
    data.valuation_range[:high].should == "1259040"
    data.change.should == "5900"
    data.change_duration.should == "30"
    data.local_real_estate.count.should == 3
    data.local_real_estate[:overview].should == "http://www.zillow.com/local-info/WA-Seattle/East-Queen-Anne/r_271856/"
    data.local_real_estate[:for_sale_by_owner].should == "http://www.zillow.com/homes/fsbo/East-Queen-Anne-Seattle-WA/"
    data.local_real_estate[:for_sale].should == "http://www.zillow.com/homes/for_sale/East-Queen-Anne-Seattle-WA/"
    data.region.should == "East Queen Anne"
    data.region_type.should == "neighborhood"
    data.region_id.should == "271856"
  end
  
  it "populates the results from GetZestimate" do
    data = Rubillow::Models::SearchResult.new(get_xml('get_zestimate.xml'))
    
    data.zpid.should == '48749425'
    data.links.count.should == 5
    data.links[:homedetails].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"
    data.links[:graphsanddata].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data"
    data.links[:mapthishome].should == "http://www.zillow.com/homes/48749425_zpid/"
    data.links[:myestimator].should == "http://www.zillow.com/myestimator/Edit.htm?zprop=48749425"
    data.links[:comparables].should == "http://www.zillow.com/homes/comps/48749425_zpid/"
    data.address[:street].should == "2114 Bigelow Ave N"
    data.address[:city].should == "Seattle"
    data.address[:state].should == "WA"
    data.address[:zipcode].should == "98109"
    data.address[:latitude].should == "47.637933"
    data.address[:longitude].should == "-122.347938"
    data.price.should == "1032000"
    data.percentile.should == "95"
    data.last_updated.strftime("%m/%d/%Y").should == "08/24/2011"
    data.valuation_range[:low].should == "866880"
    data.valuation_range[:high].should == "1259040"
    data.change.should == "5900"
    data.change_duration.should == "30"
    data.local_real_estate.count.should == 3
    data.local_real_estate[:overview].should == "http://www.zillow.com/local-info/WA-Seattle/East-Queen-Anne/r_271856/"
    data.local_real_estate[:for_sale_by_owner].should == "http://www.zillow.com/homes/fsbo/East-Queen-Anne-Seattle-WA/"
    data.local_real_estate[:for_sale].should == "http://www.zillow.com/homes/for_sale/East-Queen-Anne-Seattle-WA/"
    data.region.should == "East Queen Anne"
    data.region_type.should == "neighborhood"
    data.region_id.should == "271856"
    data.rent_zestimate[:price].should == "3379"
    data.rent_zestimate[:last_updated].should == "12/17/2012"
    data.rent_zestimate[:value_change].should == "107"
    data.rent_zestimate[:value_duration].should == "30"
    data.rent_zestimate[:valuation_range][:low].should == "2154"
    data.rent_zestimate[:valuation_range][:high].should == "5102"
  end

  it "populates the results from GetZestimate with missing region data" do
    data = Rubillow::Models::SearchResult.new(get_xml('get_zestimate_missing_region.xml'))

    data.zpid.should == '78264249'
    data.links.count.should == 4
    data.links[:homedetails].should == "http://www.zillow.com/homedetails/8663-Orchard-Loop-Rd-NE-Leland-NC-28451/78264249_zpid/"
    data.links[:graphsanddata].should == "http://www.zillow.com/homedetails/8663-Orchard-Loop-Rd-NE-Leland-NC-28451/78264249_zpid/#charts-and-data"
    data.links[:mapthishome].should == "http://www.zillow.com/homes/78264249_zpid/"
    data.links[:comparables].should == "http://www.zillow.com/homes/comps/78264249_zpid/"
    data.address[:street].should == "8663 Orchard Loop Rd NE"
    data.address[:city].should == "Leland"
    data.address[:state].should == "NC"
    data.address[:zipcode].should == "28451"
    data.address[:latitude].should == "34.217408"
    data.address[:longitude].should == "-78.054412"
    data.price.should == "136518"
    data.percentile.should == "58"
    data.last_updated.strftime("%m/%d/%Y").should == "12/27/2012"
    data.valuation_range[:low].should == "23208"
    data.valuation_range[:high].should == "203412"
    data.change.should == "-1299"
    data.change_duration.should == "30"
    data.local_real_estate.should == nil
    data.region.should == nil
  end

  it "populates the results from GetZestimate with missing valueDuration data" do
    data = Rubillow::Models::SearchResult.new(get_xml('get_zestimate_missing_value_duration.xml'))
    
    data.zpid.should == '29366758'
    data.rent_zestimate.should be_a Hash
    data.rent_zestimate[:value_duration].should be == '30' 
  end
end
