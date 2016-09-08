# Configuration of our class
module YandexImageModeration
  class << self
    # Configure it
    #
    # @yieldparam [OpenStruct] an object on which to set configuration
    #   options
    #
    # @return [OpenStruct] options
    def config
      @options ||= OptionSetter.new
      yield(@options.config) if block_given?
      @options
    end

    # Responsible for collecting options in the DSL and creating
    # lookup objects using those options.
    class OptionSetter
      attr_reader :config

      def initialize
        @config = OpenStruct.new
        @config.url = 'https://cv-albion.ydf.yandex.net/moderate'.freeze
      end
    end

    private_constant :OptionSetter
  end
end
