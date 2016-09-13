require 'yandex_image_moderation/error'

# YandexImageModeration module part for HTTP Client
module YandexImageModeration
  # @!visibility public
  # Moderation result with some useful methods
  #
  class Result
    attr_reader :data
    attr_reader :result

    def initialize(data)
      raise(::YandexImageModeration::Error::InvalidResult, 'no result data') if data.nil?
      @data = data
      parse_data
    end

    def good?
      @status.to_s == 'ok'
    end

    def bad?
      !good?
    end

    def porn_score
      @result['pornography']['scores']['explicit'] unless @result.nil? || @result['pornography'].nil?
    end

    def erotic_score
      @result['moderation']['scores']['erotic'] unless @result.nil? || @result['moderation'].nil?
    end

    def ad_score
      @result['ad']['scores']['ads'] unless @result.nil? || @result['ad'].nil?
    end

    def ad?
      ad_score > 0.5
    end

    def porn?
      porn_score > 0.3
    end

    def erotic?
      erotic_score > 0.4
    end

    def predicted_class
      @result['moderation']['predictedClass'] unless @result.nil? || @result['moderation'].nil?
    end

    private

    def parse_data
      raise(::YandexImageModeration::Error::InvalidResult,
            'invalid result') if @data.nil? || !@data.is_a?(Hash) || @data.empty?
      @status = @data['status']
      @result = @data['result']['classification'] unless @data['result'].nil?
    end
  end
end
