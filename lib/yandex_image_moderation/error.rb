module YandexImageModeration
  # Error messages that can be raised by this gem. To catch any
  # related error message, use Error::Base.
  #
  #   begin
  #     ...
  #   rescue YandexImageModeration::Error::Base => e
  #     puts "YandexImageModeration Error: #{e.message}"
  #   end
  module Error
    # Top-level error. All other timezone errors subclass this one.
    class Base < StandardError; end
    # Indicates an invalid result received from the server.
    class InvalidResult < Base; end
    # Indicates a request failure.
    class Moderate < Base; end
    # Indicates an invalid configuration.
    class InvalidConfig < Base; end
  end
end
