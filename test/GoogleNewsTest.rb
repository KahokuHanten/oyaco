# -*- coding: utf-8 -*-
class GoogleNewsTest < ActiveSupport::TestCase
  def test_get_google_news
    news = LocalInfo.get_google_news("埼玉")
    assert !news.empty?
  end
end
