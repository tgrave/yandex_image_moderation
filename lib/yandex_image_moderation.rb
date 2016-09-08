require 'base64'
require 'yandex_image_moderation/version'
require 'yandex_image_moderation/config'
require 'yandex_image_moderation/http_client'

# YandexImageModeration gem code
module YandexImageModeration
  class << self
    # Returns an instance of the request handler.
    #
    # @return [#post] an instance of a request handler
    def client
      @client ||= ::YandexImageModeration::NetHTTPClient.new(config)
    end

    def boundary
      @boundary ||= Base64.strict_encode64(Random.rand(4_611_686_018_427_387_903).to_s).gsub(/^([^=]+)/, '\1')
    end

    def moderate(file)
      return if file.nil? || !File.exist?(file)

      url = @options.url
      parse_response client.post(url, prepare_body(file),
                                 'Content-Type' => "multipart/form-data, boundary=#{boundary}")
    end

    def parse_response(response)
    end

    def prepare_body(file)
      post_body = prepare_file_body [], file
      post_body = prepare_auth_body post_body, client: @options.client, token: @options.token
      post_body << "--#{boundary}--\r\n"
      post_body
    end

    def prepare_file_body(post_body, file)
      post_body << "--#{boundary}\r\n"
      post_body << "Content-Disposition: form-data; name=\"file\"; filename=\"#{File.basename(file)}\"\r\n"
      post_body << "Content-Type: image/jpeg\r\n"
      post_body << "Content-Transfer-Encoding: base64\r\n"
      post_body << "\r\n"
      post_body << Base64.encode64(File.read(file)).gsub(/\n/, "\r\n")
      post_body
    end

    def prepare_auth_body(post_body, params)
      params.each do |k, v|
        post_body << "--#{boundary}\r\n"
        post_body << "Content-Disposition: form-data; name=\"#{k}\"\r\n"
        post_body << "\r\n"
        post_body << "#{v}\r\n"
      end
      post_body
    end
  end
end
