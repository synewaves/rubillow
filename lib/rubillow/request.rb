require 'cgi'
require 'net/http'
require 'uri'

module Rubillow
  class Request
    def self.get(path, options = {})
      zwsid = Rubillow.configuration.zwsid

      unless zwsid.nil?
        options[:zws_id] ||= zwsid
      end

      response = request.get(uri(path, options))

      case response.code.to_i
      when 200
        response.body
      else
        false
      end
    end
    
    def self.request
      if Rubillow.configuration.http_proxy
        uri = URI.parse(Rubillow.configuration.http_proxy)
        user, pass = uri.userinfo.split(/:/) if uri.userinfo
        http = Net::HTTP::Proxy(uri.host, uri.port, user, pass).start(Rubillow.configuration.host, Rubillow.configuration.port)
      else
        http = Net::HTTP.new(Rubillow.configuration.host, Rubillow.configuration.port)
      end
      
      http.open_timeout = Rubillow.configuration.http_open_timeout
      http.read_timeout = Rubillow.configuration.http_read_timeout
      http
    end
    
    def self.uri(path, options = {})
      path = Rubillow.configuration.path + path
      "/#{path}.htm?#{hash_to_query_string(options)}"
    end

    def self.hash_to_query_string(hash)
      hash.sort_by { |key, value|
        key.to_s
      }.delete_if { |key, value|
        value.to_s.empty?
      }.collect { |key, value|
        "#{CGI.escape(key.to_s).gsub(/\_/, '-')}=#{CGI.escape(value.to_s)}"
      }.join("&")
    end
  end
end