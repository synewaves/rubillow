module Rubillow
  class Configuration
    attr_accessor :host
    attr_accessor :port
    attr_accessor :path
    attr_accessor :zwsid
    attr_accessor :http_open_timeout
    attr_accessor :http_read_timeout
    attr_accessor :http_proxy
    
    def initialize
      self.host              = "www.zillow.com"
      self.port              = 80
      self.path              = "webservice/"
      self.http_open_timeout = 2
      self.http_read_timeout = 2
    end
  end
end