## 0.0.7 / 2013-06-16

  * Remove unnecessary chomp call from value duration

## 0.0.6 / 2013-04-10
  
  * Fix case where Zillow returns multiple results for an address -- assume first address for result
  * Fix RentZestimate bug when valueChange doesn't have a duration.
  * Fix common scenarios where xml nodes are not present

## 0.0.5 / 2013-01-12

  * Include RentZestimate if available
  * Check if region info exists before populating

## 0.0.4 / 2012-01-31

  * Check if lastSoldDate exists before parsing

## 0.0.3 / 2012-01-14

  * Fix GetUpdatedPropertyDetails date requirement
  * Fix typo on method name
  * Updated documentation
  * Added Travis CI and dependency tracking
  * Remove unnecessary testing dependencies

## 0.0.2 / 2011-09-27

  * Remove unnecessary dependencies of activesupport and i18n

## 0.0.1 / 2011-08-27

  * Covers all Zillow API endpoints
  * Code documentation
