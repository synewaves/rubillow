require "rubillow/version"
require "rubillow/configuration"
require "rubillow/request"
require "rubillow/home_valuation"
require "rubillow/mortgage"
require "rubillow/postings"
require "rubillow/property_details"
require "rubillow/neighborhood"
require "rubillow/models"

require 'date'

# Top-level interface to Rubillow
module Rubillow
  # Call this method to modify defaults in your initializers.
  #
  # @example
  #   Rubillow.configure do |configuration|
  #     configuration.zwsid = "abcd1234"
  #   end
  #
  # @yield [Configuration] The current configuration.
  def self.configure
    yield(configuration)
  end
  
  # @return [Configuration] Current configuration.
  def self.configuration
    @@configuration ||= Configuration.new
  end
end
