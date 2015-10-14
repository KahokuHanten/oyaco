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

=begin
  test "should get google news" do
    news = LocalInfo.get_google_news("埼玉")
    assert !news.has_key?("error")
  end
=end
=begin
  google apiのリクエスト制限に掛かるため
  テストをコメントアウトする
  test "should get any hobby news" do
    hobby_news = LocalInfo.get_hobby_news("イラスト")
    if !hobby_news.has_key?("error")
      && !hobby_news["items"].blank?
    then
      hobby_news["items"].each do |a_news|
        assert a_news["title"].blank?
        assert a_news["link"]
      end
    end
  end
=end
end
