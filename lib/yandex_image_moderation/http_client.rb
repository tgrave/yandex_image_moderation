require 'uri'
require 'net/http'
require 'net/http/post/multipart'

# YandexImageModeration module part for HTTP Client
module YandexImageModeration
  # @!visibility private
  # A basic HTTP Client that handles requests to Yandex.
  #
  class NetHTTPClient
    def initialize(config)
      uri = parse_url config
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.open_timeout = config.open_timeout || 10
      @http.read_timeout = config.read_timeout || 30
      @http.use_ssl = !(config.url =~ /^https/i).nil?
    end

    def post(url, body, headers)
      request = Net::HTTP::Post::Multipart.new(url, body)
      headers.each { |k, v| request[k.to_s] = v } unless headers.nil? || !headers.is_a?(Hash)
      @http.request(request)
    end

    protected

    def parse_url(config)
      raise(::YandexImageModeration::Error::InvalidConfig, 'missing url') if config.url.to_s.empty?
      URI.parse(config.url)
    end
  end
end
