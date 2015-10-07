# -*- coding: utf-8 -*-
require 'test_helper'

class LocalInfoTest < ActiveSupport::TestCase
  test "should get anything" do
    assert_not_nil LocalInfo.get_weather_warnings(1)
    assert_not_nil LocalInfo.get_weather_warnings(47)
  end

  test "should get nil on any errors" do
    assert_nil LocalInfo.get_weather_warnings(0)
    assert_nil LocalInfo.get_weather_warnings(100)
  end

  test "should get google news" do
    news = LocalInfo.get_google_news("埼玉")
    assert !news.has_key?("error")
  end
end
