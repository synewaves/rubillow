require "rubillow/version"
require "rubillow/configuration"
require "rubillow/request"
require "rubillow/home_valuation"
require "rubillow/mortgage"
require "rubillow/postings"
require "rubillow/property_details"
require "rubillow/neighborhood"
require "rubillow/models"

# Top-level interface to Rubillow
module Rubillow
  # Call this method to modify defaults in your initializers.
  #
  # @example
  #   Rubillow.configure do |configuration|
  #     configuration.http_open_timeout = 1
  #     configuration.http_read_timeout = 1
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
