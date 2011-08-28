module Rubillow
  # Configuration options
  class Configuration
    # @return [String] HTTP host (defaults to +www.zillow.com+)
    attr_accessor :host
    
    # @return [Integer] HTTP port (defaults to +80+)
    attr_accessor :port
    
    # @return [String] relative service path (defaults to +webservice/+)
    attr_accessor :path
    
    # @return [String] Zillow API key. See {http://www.zillow.com/howto/api/APIOverview.htm}.
    attr_accessor :zwsid
    
    # @return [Integer] HTTP connection timeout seconds (defaults to +2+)
    attr_accessor :http_open_timeout
    
    # @return [Integer] HTTP read timeout seconds (defaults to +2+)
    attr_accessor :http_read_timeout
    
    # @private
    def initialize
      self.host              = "www.zillow.com"
      self.port              = 80
      self.path              = "webservice/"
      self.http_open_timeout = 2
      self.http_read_timeout = 2
    end
  end
end