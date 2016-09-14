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

    answer = YandexImageModeration.moderate('/var/www/uploads/test.jpg')
    # => #<YandexImageModeration::Result:0x0055ae52e8a7a0
     @data=
      {"status"=>"ok",
       "revision"=>"33e3dfd4d",
       "revisionDate"=>"2016-08-29 17:06:06 +0300",
       "result"=>
        {"classification"=>
          {"gender"=>
            {"predictedClass"=>"male",
             "scores"=>{"female"=>0.0752159, "male"=>0.924784}},
           "moderation"=>
            {"predictedClass"=>"other",
             "scores"=>
              {"other"=>0.998316,
               "erotic"=>1.01304e-05,
               "inappropriateOrChild"=>0.00149277,
               "approvedPersonNotChild"=>3.49765e-05,
               "many"=>0.000146203}},
           "pornography"=>
            {"predictedClass"=>"other",
             "scores"=>{"explicit"=>9.50646e-09, "other"=>0.99999999049354}},
           "ad"=>
            {"predictedClass"=>"not_ads",
             "scores"=>{"ads"=>0.0229261, "not_ads"=>0.977074}}}}},
     @result=
      {"gender"=>
        {"predictedClass"=>"male",
         "scores"=>{"female"=>0.0752159, "male"=>0.924784}},
       "moderation"=>
        {"predictedClass"=>"other",
         "scores"=>
          {"other"=>0.998316,
           "erotic"=>1.01304e-05,
           "inappropriateOrChild"=>0.00149277,
           "approvedPersonNotChild"=>3.49765e-05,
           "many"=>0.000146203}},
       "pornography"=>
        {"predictedClass"=>"other",
         "scores"=>{"explicit"=>9.50646e-09, "other"=>0.99999999049354}},
       "ad"=>
        {"predictedClass"=>"not_ads",
         "scores"=>{"ads"=>0.0229261, "not_ads"=>0.977074}}},
     @status="ok">

You can check if the request was successful or not:

    answer.good?
    # => true
    answer.bad?
    # => false
    answer.status
    # => "ok"

Then you can access to the resulting data directly through the *result* attribute:

    answer.result['ad']['predictedClass']
    # => "not_ads"

Also you can check either the image was classified as porn, erotic or ad and get scores for the classifications (scores are between 0 and 1):

    answer.porn?
    # => false
    answer.erotic?
    # => false
    answer.ad?
    # => false
    answer.porn_score
    # => 9.50646e-09
    answer.erotic_score
    # => 1.01304e-05
    answer.ad_score
    # => 0.0229261

And another one shortcut is provided - for getting predicted class during moderation:

    answer.predicted_class
    # => "other"
    
For a clarification on the returned data, predicted classes and scores please consult Yandex Image Moderation API documentation. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tgrave/yandex_image_moderation.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Build Status [![Build Status](https://secure.travis-ci.org/tgrave/yandex_image_moderation.png?branch=master)](http://travis-ci.org/tgrave/yandex_image_moderation)
