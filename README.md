# YandexImageModeration

This gem provides a class for access to Yandex Image Moderation API
(https://imagemoderation.yandexdatafactory.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yandex_image_moderation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex_image_moderation

## Configuration

For Yandex API access you have to provide an API key. Do it by calling config method of the YandexImageModeration class:

```ruby
YandexImageModeration.config do |c|
  c.token = 'your_API_key'
end
```

If you use Rails, this configuration would probably go into a proper initializer.

In some cases you may need to change URL of the API (i.e. when you use not the SAAS API, but a docker version on your own server).
To override the standard URL just add url attribute to the config. In the URL provide the path to the *moderate* service, do not add any parameters like *?model=moderate...*

```ruby
YandexImageModeration.config do |c|
  c.url = 'http://your_server/path_to/moderate'
  c.token = 'your_API_key'
end
```

## Usage

To moderate an image (remember: Yandex API works with JPEG only) just call a *moderate* methods with a path to the image file as a parameter:

```ruby
result = YandexImageModeration.moderate('/var/www/uploads/test.jpg')
puts result


```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yandex_image_moderation.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Build Status [![Build Status](https://secure.travis-ci.org/tgrave/yandex_image_moderation.png?branch=master)](http://travis-ci.org/tgrave/yandex_image_moderation)
