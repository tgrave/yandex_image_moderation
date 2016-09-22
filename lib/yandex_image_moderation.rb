require 'json'
require 'yandex_image_moderation/version'
require 'yandex_image_moderation/config'
require 'yandex_image_moderation/client'
require 'yandex_image_moderation/result'

# YandexImageModeration gem code
module YandexImageModeration
  class << self
    # Returns an instance of the request handler.
    #
    # @return [#post] an instance of a request handler
    def client
      @client ||= ::YandexImageModeration::Client.new(config)
    end

    # Send a request for moderation
    #
    # @return [Result] an instance of the Result
    def moderate(file)
      return if file.nil? || !File.exist?(file)

      url = "#{config.url}?models=moderation,gender,pornography,ad"
      parse_response client.post(url, prepare_body(file))
    end

    protected

    def parse_response(response)
      return unless response.status == 200
      raise(::YandexImageModeration::Error::InvalidResult, 'empty response') if response.content.nil?
      ::YandexImageModeration::Result.new JSON.parse(response.content)
    end

    def prepare_body(file)
      {
        file: File.open(file, 'r'),
        token: @options.config.token
      }
    end
  end
end
