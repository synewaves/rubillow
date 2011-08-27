require "rubillow/version"
require "rubillow/configuration"
require "rubillow/request"
require "rubillow/home_valuation"
require "rubillow/mortgage"
require "rubillow/postings"
require "rubillow/property_details"
require "rubillow/neighborhood"
require "rubillow/models"

module Rubillow
  def self.configure
    yield(configuration)
  end
  
  def self.configuration
    @@configuration ||= Configuration.new
  end
end
