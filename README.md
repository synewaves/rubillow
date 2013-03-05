# Rubillow

Rubillow is a ruby library to access the [Zillow API](http://www.zillow.com/howto/api/APIOverview.htm).

Supports all of the API methods, with real ruby classes returned for each call.

### [Home Valuation API](http://www.zillow.com/howto/api/HomeValuationAPIOverview.htm)
* [GetSearchResults](http://www.zillow.com/howto/api/GetSearchResults.htm)
* [GetZestimate](http://www.zillow.com/howto/api/GetZestimate.htm)
* [GetChart](http://www.zillow.com/howto/api/GetChart.htm)
* [GetComps](http://www.zillow.com/howto/api/GetComps.htm)

### [Neighborhood Data](http://www.zillow.com/webtools/neighborhood-data/)
* [GetDemographics](http://www.zillow.com/howto/api/GetDemographics.htm)
* [GetRegionChildren](http://www.zillow.com/howto/api/GetRegionChildren.htm)
* [GetRegionChart](http://www.zillow.com/howto/api/GetRegionChart.htm)

### [Mortgage API](http://www.zillow.com/howto/api/MortgageAPIOverview.htm)
* [GetRateSummary](http://www.zillow.com/howto/api/GetRateSummary.htm)
* [GetMonthlyPayments](http://www.zillow.com/howto/api/GetMonthlyPayments.htm)

### [Property Details API](http://www.zillow.com/howto/api/PropertyDetailsAPIOverview.htm)
* [GetDeepSearchResults](http://www.zillow.com/howto/api/GetDeepSearchResults.htm)
* [GetDeepComps](http://www.zillow.com/howto/api/GetDeepComps.htm)
* [GetUpdatedPropertyDetails](http://www.zillow.com/howto/api/GetUpdatedPropertyDetails.htm)

### [Postings API](http://www.zillow.com/howto/api/GetRegionPostings.htm)
* [GetRegionPostings](http://www.zillow.com/howto/api/GetRegionPostings.htm)

# Installing

    gem install rubillow

or add the following to your Gemfile:

    gem "rubillow"

# Examples

Adding setup into an initializer:

    Rubillow.configure do |configuration|
      configuration.zwsid = "abcd1234"
    end

Getting property Zestimate:

    property = Rubillow::HomeValuation.zestimate({ :zpid => '48749425' })
    if property.success?
      puts property.price
    end

# Documentation

You should find the documentation for your version of Rubillow on [Rubygems](http://rubygems.org/gems/rubillow).

# More Information

* [Rubygems](http://rubygems.org/gems/rubillow)
* [Issues](http://github.com/synewaves/rubillow/issues)

# Build & Dependency Status

[![Gem Version](https://badge.fury.io/rb/rubillow.png)](http://badge.fury.io/rb/rubillow)
[![Build Status](https://travis-ci.org/synewaves/rubillow.png?branch=master)](https://travis-ci.org/synewaves/rubillow)
[![Dependency Status](https://gemnasium.com/synewaves/rubillow.png?travis)](https://gemnasium.com/synewaves/rubillow)
[![Code Climate](https://codeclimate.com/github/synewaves/rubillow.png)](https://codeclimate.com/github/synewaves/rubillow)
[![Coverage Status](https://coveralls.io/repos/synewaves/rubillow/badge.png?branch=master)](https://coveralls.io/r/synewaves/rubillow)

# License

Rubillow uses the MIT license. See LICENSE for more details.