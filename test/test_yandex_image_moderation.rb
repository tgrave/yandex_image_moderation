require 'yandex_image_moderation'
require 'minitest/autorun'
require 'rspec/mocks'

class TestYandexImageModeration < ::Minitest::Test
  include RSpec::Mocks::ExampleMethods

  def before_setup
    RSpec::Mocks.setup
    super
  end

  def stub_response(which)
    allow(@response).to receive(:code).and_return(which == 'bad' ? '500' : '200')
    result = File.open("test/data/#{which}_response.json").read unless which == 'error'
    allow(@response).to receive(:body).and_return(result)
  end

  def stub_post(which = 'good')
    @client ||= instance_double ::YandexImageModeration::NetHTTPClient
    @response ||= instance_double Net::HTTPOK
    stub_response which
    allow(@client).to receive(:post).and_return(@response)
    allow(::YandexImageModeration).to receive(:client).and_return(@client)
  end

  def unstub_post
    allow(::YandexImageModeration).to receive(:client).and_call_original
  end

  def test_config
    assert_equal ::YandexImageModeration.config.url, 'https://cv-albion.ydf.yandex.net/moderate'
    ::YandexImageModeration.config do |c|
      c.url = 'http://test.url'
      c.some_param = 'value'
    end
    assert_equal ::YandexImageModeration.config.url, 'http://test.url'
    assert_equal ::YandexImageModeration.config.some_param, 'value'
    ::YandexImageModeration.config do |c|
      c.url = 'https://cv-albion.ydf.yandex.net/moderate'
    end
  end

  def test_bad_config
    ::YandexImageModeration.config do |c|
      c.url = nil
    end
    assert_raises ::YandexImageModeration::Error::InvalidConfig do
      ::YandexImageModeration::NetHTTPClient.new(::YandexImageModeration.config)
    end
    ::YandexImageModeration.config do |c|
      c.url = 'https://cv-albion.ydf.yandex.net/moderate'
    end
  end

  def test_bad_result
    stub_post('error')
    assert_raises ::YandexImageModeration::Error::InvalidResult do
      ::YandexImageModeration.moderate('test/data/picture.jpg')
    end
    unstub_post
  end

  def test_moderate
    stub_post
    result = ::YandexImageModeration.moderate('test/data/picture.jpg')
    assert result.good?
    assert_equal result.ad_score, 0.0107738
    refute result.porn?
    unstub_post
  end
end
