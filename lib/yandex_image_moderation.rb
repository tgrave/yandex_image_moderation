require 'yandex_image_moderation/version'

# YandexImageModeration gem code
module YandexImageModeration
  def moderate(file)
    return if file.nil?

    _name, _path = *get_file_params(file)
  end

  def get_file_params(file)
  end
end
