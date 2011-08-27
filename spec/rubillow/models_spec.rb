require "spec_helper"
require "nokogiri"

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
  end
end

describe Rubillow::Models::Chart do
  it "populates the results" do
    data = Rubillow::Models::Chart.new(get_xml('get_chart.xml'))
    
    data.width.should == 300
    data.height.should == 150
    data.url.should == "http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425"
    data.graphs_and_data == "http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data"
  end
  
  it "should format correctly for HTML" do
    data = Rubillow::Models::Chart.new(get_xml('get_chart.xml'))
    
    data.to_html.should == "<a href='http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#charts-and-data'><img src='http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425' height='150' width='300' /></a>"
  end
end

describe Rubillow::Models::Comps do
  it "populates the results" do
    data = Rubillow::Models::Comps.new(get_xml('get_comps.xml'))
    
    data.principal.should be_a(Rubillow::Models::SearchResult)
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
    
    comp = data.comparables['0.0813344']
    comp.should be_a(Rubillow::Models::SearchResult)
    
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
  end
end

describe Rubillow::Models::RateSummary do
  it "populates the results" do
    data = Rubillow::Models::RateSummary.new(get_xml('get_rate_summary.xml'))
    
    data.today[:thiry_year_fixed].should == "4.01"
    data.today[:fifteen_year_fixed].should == "3.27"
    data.today[:five_one_arm].should == "2.73"
    data.last_week[:thiry_year_fixed].should == "4.02"
    data.last_week[:fifteen_year_fixed].should == "3.27"
    data.last_week[:five_one_arm].should == "2.84"
  end
end

describe Rubillow::Models::MonthlyPayments do
  it "populates the results" do
    data = Rubillow::Models::MonthlyPayments.new(get_xml('get_monthly_payments.xml'))
    
    data.thirty_year_fixed[:rate].should == "4.01"
    data.thirty_year_fixed[:principal_and_interest].should == "1219"
    data.thirty_year_fixed[:insurance].should == "93"
    data.fifteen_year_fixed[:rate].should == "3.27"
    data.fifteen_year_fixed[:principal_and_interest].should == "1795"
    data.fifteen_year_fixed[:insurance].should == "93"
    data.five_one_arm[:rate].should == "3.27"
    data.five_one_arm[:principal_and_interest].should == "1039"
    data.five_one_arm[:insurance].should == "93"
    data.down_payment.should == "45000"
    data.monthly_property_taxes.should == "193"
    data.monthly_hazard_insurance == "50"
  end
end

describe Rubillow::Models::Postings do
  it "populates the data" do
    data = Rubillow::Models::Postings.new(get_xml('get_region_postings.xml'))
    
    data.region_id.should == "99562"
    data.links.count.should == 3
    data.make_me_move.count.should == 90
    data.for_sale_by_owner.count.should == 1
    data.for_sale_by_agent.count.should == 8
    data.report_for_sale.count.should == 0
    data.for_rent.count.should == 0
  end
end

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
end

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
    data.price.should == "1290000"
    data.neighborhood.should == "Queen Anne"
    data.school_district.should == "Seattle"
    data.elementary_school.should == "John Hay"
    data.middle_school.should == "McClure"
    data.home_description.should == "Bright, spacious, 4 bedroom/3 bath Craftsman, with stunning, expansive views, on one of Queen Anne's finest streets. Views of Lk Union, Lk Washington,the Cascades from Mt. Baker to Mt. Rainier, and the city-from two levels and 2 view decks. Craftsman charm intact: hardwood floors, cove moldings, crystal doorknobs, Batchelder tile fireplace. Huge gourmet eat-in kitchen with slab granite countertops, deluxe master suite, theater-like media room, level rear yard with garden space and covered patio."
    data.posting[:status].should == "Active"
    data.posting[:agent_name].should == "John Blacksmith"
    data.posting[:agent_profile_url].should == "/profile/John.Blacksmith"
    data.posting[:brokerage].should == "Lake and Company Real Estate"
    data.posting[:type].should == "For sale by agent"
    data.posting[:last_updated_date].should == "2008-06-05 10:28:00.0"
    data.posting[:external_url].should == "http://mls.lakere.com/srch_mls/detail.php?mode=ag&LN=28097669&t=listings&l="
    data.posting[:mls].should == "28097669"
    data.images_count.should == "17"
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