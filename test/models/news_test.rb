require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "should get anything" do
    assert_not_nil News.weather_warnings(1)
    assert_not_nil News.weather_warnings(47)
  end

  test "should get nil on any errors" do
    assert_nil News.weather_warnings(0)
    assert_nil News.weather_warnings(100)
  end

  test "should get local news" do
    pref = "埼玉"
    news = News.local(pref)
    if news.has_key?("items")&&!news["items"].blank? then
      assert !news["items"].blank?
    elsif news.has_key?("error_usage_limit") then
      assert_equal(News::API_USAGE_LIMIT,news["error_usage_limit"])
    else
      assert_equal(pref+News::NEWS_NOT_FOUND_MESSAGE,news["error"])
    end
  end

  test "should get any hobby news or error message" do
    hobby = "イラスト"
    hobby_news = News.hobby(hobby)
    if hobby_news.has_key?("items")&&!hobby_news["items"].blank? then
      link = nil
      hobby_news["items"].first(1).each do |a_news|
        link = a_news["link"]
      end
      assert !link.blank?
    elsif hobby_news.has_key?("error_usage_limit") then
      assert_equal(News::API_USAGE_LIMIT,hobby_news["error_usage_limit"])
    else
      assert_equal(hobby+News::NEWS_NOT_FOUND_MESSAGE,hobby_news["error"])
    end
  end
end
