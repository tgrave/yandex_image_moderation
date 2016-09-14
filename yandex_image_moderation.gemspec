# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yandex_image_moderation/version'

Gem::Specification.new do |spec|
  spec.name          = 'yandex_image_moderation'
  spec.version       = YandexImageModeration::VERSION
  spec.authors       = ['Sergey Tsvetkov']
  spec.email         = ['stsvetkov@gmail.com']

  spec.summary       = "yandex_image_moderation-#{YandexImageModeration::VERSION}"
  spec.description   = 'An interface for Yandex Image Moderation API'
  spec.homepage      = 'https://github.com/tgrave/yandex_image_moderation'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'rspec-mocks'
  spec.add_development_dependency 'rubocop'
end
