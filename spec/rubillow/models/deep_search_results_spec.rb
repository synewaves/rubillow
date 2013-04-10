require "spec_helper"

describe Rubillow::Models::DeepSearchResult do
  it "populates the data" do
    data = Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results.xml'))
    
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
    data.fips_county.should == "53033"
    data.tax_assessment_year.should == "2010"
    data.tax_assessment.should == "872000.0"
    data.year_built.should == "1924"
    data.lot_size_square_feet.should == "4680"
    data.finished_square_feet.should == "3470"
    data.bathrooms.should == "3.0"
    data.bedrooms.should == "4"
    data.total_rooms.should == ""
    data.last_sold_date.strftime("%m/%d/%Y").should == "11/26/2008"
    data.last_sold_price.should == "1025000"
    data.use_code.should == "SingleFamily"
  end

  it "populates the data" do
    data = Rubillow::Models::DeepSearchResult.new(get_xml('get_deep_search_results_duplicated.xml'))
    
    data.zpid.should == '66109976'
    data.links.count.should == 4
    data.links[:homedetails].should == "http://www.zillow.com/homedetails/3651-Louisiana-St-APT-205-San-Diego-CA-92104/2126762315_zpid/"
    data.links[:graphsanddata].should == "http://www.zillow.com/homedetails/3651-Louisiana-St-APT-205-San-Diego-CA-92104/66109976_zpid/#charts-and-data"
    data.links[:mapthishome].should == "http://www.zillow.com/homes/2126762315_zpid/"
    data.links[:comparables].should == "http://www.zillow.com/homes/comps/2126762315_zpid/"
    data.address[:street].should == "3651 Louisiana St APT 205"
    data.address[:city].should == "San Diego"
    data.address[:state].should == "CA"
    data.address[:zipcode].should == "92104"
    data.address[:latitude].should == "32.744895"
    data.address[:longitude].should == "-117.139743"
    data.price.should == "249461"
    data.percentile.should == "0"
    data.last_updated.strftime("%m/%d/%Y").should == "04/02/2013"
    data.valuation_range[:low].should == "219526"
    data.valuation_range[:high].should == "271912"
    data.change.should == "20262"
    data.change_duration.should == "30"
    data.local_real_estate.count.should == 3
    data.local_real_estate[:overview].should == "http://www.zillow.com/local-info/CA-San-Diego/North-Park/r_274717/"
    data.local_real_estate[:for_sale_by_owner].should == "http://www.zillow.com/north-park-san-diego-ca/fsbo/"
    data.local_real_estate[:for_sale].should == "http://www.zillow.com/north-park-san-diego-ca/"
    data.region.should == "North Park"
    data.region_type.should == "neighborhood"
    data.region_id.should == "274717"
    data.fips_county.should == "6073"
    data.tax_assessment_year.should == "2012"
    data.tax_assessment.should == "180539.0"
    data.year_built.should == "1985"
    data.lot_size_square_feet.should == ""
    data.finished_square_feet.should == "800"
    data.bathrooms.should == "2.0"
    data.bedrooms.should == "2"
    data.total_rooms.should == ""
    data.last_sold_date.strftime("%m/%d/%Y").should == "06/10/2011"
    data.last_sold_price.should == "186000"
    data.use_code.should == "Condominium"
  end

  it "doesn't raise an error when data is missing" do
    lambda {
      Rubillow::Models::DeepSearchResult.new(get_xml("get_deep_search_results_missing_data.xml"))
    }.should_not raise_error
  end
end
