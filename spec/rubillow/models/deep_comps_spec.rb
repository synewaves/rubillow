require "spec_helper"

describe Rubillow::Models::DeepComps do
  it "populates the data" do
    data = Rubillow::Models::DeepComps.new(get_xml('get_deep_comps.xml'))
    
    data.principal.should be_a(Rubillow::Models::DeepSearchResult)
    data.comparables.count.should == 5
    
    principal = data.principal
    principal.zpid.should == '48749425'
    principal.links.count.should == 5
    principal.links[:homedetails].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"
    principal.links[:graphsanddata].should == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data"
    principal.links[:mapthishome].should == "http://www.zillow.com/homes/48749425_zpid/"
    principal.links[:myestimator].should == "http://www.zillow.com/myestimator/Edit.htm?zprop=48749425"
    principal.links[:comparables].should == "http://www.zillow.com/homes/comps/48749425_zpid/"
    principal.address[:street].should == "2114 Bigelow Ave N"
    principal.address[:city].should == "Seattle"
    principal.address[:state].should == "WA"
    principal.address[:zipcode].should == "98109"
    principal.address[:latitude].should == "47.637933"
    principal.address[:longitude].should == "-122.347938"
    principal.price.should == "1032000"
    principal.percentile.should == "95"
    principal.last_updated.strftime("%m/%d/%Y").should == "08/24/2011"
    principal.valuation_range[:low].should == "866880"
    principal.valuation_range[:high].should == "1259040"
    principal.change.should == "5900"
    principal.change_duration.should == "30"
    principal.local_real_estate.count.should == 3
    principal.local_real_estate[:overview].should == "http://www.zillow.com/local-info/WA-Seattle/East-Queen-Anne/r_271856/"
    principal.local_real_estate[:for_sale_by_owner].should == "http://www.zillow.com/homes/fsbo/East-Queen-Anne-Seattle-WA/"
    principal.local_real_estate[:for_sale].should == "http://www.zillow.com/homes/for_sale/East-Queen-Anne-Seattle-WA/"
    principal.region.should == "East Queen Anne"
    principal.region_type.should == "neighborhood"
    principal.region_id.should == "271856"
    principal.fips_county.should == ""
    principal.tax_assessment_year.should == "2010"
    principal.tax_assessment.should == "872000.0"
    principal.year_built.should == "1924"
    principal.lot_size_square_feet.should == "4680"
    principal.finished_square_feet.should == "3470"
    principal.bathrooms.should == "3.0"
    principal.bedrooms.should == "4"
    principal.total_rooms.should == ""
    principal.last_sold_date.strftime("%m/%d/%Y").should == "11/26/2008"
    principal.last_sold_price.should == "1025000"
    principal.use_code.should == ""
  
    comp = data.comparables["0.0813344"]
    comp.should be_a(Rubillow::Models::DeepSearchResult)
    comp.zpid.should == '48768095'
    comp.links.count.should == 5
    comp.links[:homedetails].should == "http://www.zillow.com/homedetails/2538-Mayfair-Ave-N-Seattle-WA-98109/48768095_zpid/"
    comp.links[:graphsanddata].should == "http://www.zillow.com/homedetails/2538-Mayfair-Ave-N-Seattle-WA-98109/48768095_zpid/#charts-and-data"
    comp.links[:mapthishome].should == "http://www.zillow.com/homes/48768095_zpid/"
    comp.links[:myestimator].should == "http://www.zillow.com/myestimator/Edit.htm?zprop=48768095"
    comp.links[:comparables].should == "http://www.zillow.com/homes/comps/48768095_zpid/"
    comp.address[:street].should == "2538 Mayfair Ave N"
    comp.address[:city].should == "Seattle"
    comp.address[:state].should == "WA"
    comp.address[:zipcode].should == "98109"
    comp.address[:latitude].should == "47.642566"
    comp.address[:longitude].should == "-122.352512"
    comp.price.should == "584400"
    comp.percentile.should == "75"
    comp.last_updated.strftime("%m/%d/%Y").should == "08/24/2011"
    comp.valuation_range[:low].should == "449988"
    comp.valuation_range[:high].should == "625308"
    comp.change.should == "-100"
    comp.change_duration.should == "30"
    comp.local_real_estate.count.should == 3
    comp.local_real_estate[:overview].should == "http://www.zillow.com/local-info/WA-Seattle/North-Queen-Anne/r_271942/"
    comp.local_real_estate[:for_sale_by_owner].should == "http://www.zillow.com/homes/fsbo/North-Queen-Anne-Seattle-WA/"
    comp.local_real_estate[:for_sale].should == "http://www.zillow.com/homes/for_sale/North-Queen-Anne-Seattle-WA/"
    comp.region.should == "North Queen Anne"
    comp.region_type.should == "neighborhood"
    comp.region_id.should == "271942"
    comp.fips_county.should == ""
    comp.tax_assessment_year.should == "2010"
    comp.tax_assessment.should == "431000.0"
    comp.year_built.should == "1955"
    comp.lot_size_square_feet.should == "16514"
    comp.finished_square_feet.should == "2600"
    comp.bathrooms.should == "2.75"
    comp.bedrooms.should == "4"
    comp.total_rooms.should == "8"
    comp.last_sold_date.strftime("%m/%d/%Y").should == "07/27/2011"
    comp.last_sold_price.should == "545000"
    comp.use_code.should == ""
  end
end