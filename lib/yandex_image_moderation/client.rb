require 'httpclient'

# YandexImageModeration module part for HTTP Client
module YandexImageModeration
  # @!visibility private
  # A basic HTTP Client that handles requests to Yandex.
  #
  class Client
    def initialize(config)
      raise(::YandexImageModeration::Error::InvalidConfig, 'missing url') if config.url.to_s.empty?
      @http = ::HTTPClient.new base_url: config.url
      @http.connect_timeout = config.open_timeout || config.connect_timeout || 60
      @http.receive_timeout = config.read_timeout || config.receive_timeout || 60
    end

    def post(url, params)
      @http.post(url, params)
    end
  end
end
