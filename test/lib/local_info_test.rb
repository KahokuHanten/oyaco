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
    if !news.has_key?("error") then
      assert !news["items"].blank?
    else
      assert !news["error"].blank?
    end

  end

  test "should get any hobby news or error message" do
    hobby_news = LocalInfo.get_hobby_news("イラスト")
    if hobby_news.has_key?("items") then
      link = nil
      hobby_news["items"].first(1).each do |a_news|
        link = a_news["link"]
      end
      assert !link.blank?
    else
      assert !hobby_news["error"].blank?
    end
  end
end
