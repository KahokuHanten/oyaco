# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'

class LocalInfo
  WW_URL = 'http://weather.livedoor.com/forecast/rss/warn/'

  def self.get_weather_warnings(id)
    doc = ""
    messages = []
    pref = "%02d" % id
    if pref == "01" then
      pref = "01b" # FIXME
    end

    begin
      doc = Nokogiri::XML(open(WW_URL + pref + '.xml').read)
      doc.xpath('//item/description').each {|node|
        messages.push(node.text) unless /livedoor/.match(node.text)
      }
    rescue
      messages = nil
    end
    messages
  end

  def self.get_google_news(pref_name)
    searchtext = pref_name+" ニュース"
    return GoogleCustomSearchApi.search(searchtext)
  end
  def self.get_hobby_news(hobby)
    #一旦、スケルトンで実装
    #GoogleCustomerSearch APIからニュースを取得する
    #if keyにerrorがセットされているもしっくはitemsが空の場合は
    #  エラーメッセージを返却する
    #for
    #  if link にg=jfnが含まれている then
    #    返却するハッシュの先頭に挿入する
    #  else
    #    返却ハッシュの末尾に挿入する
  end
end
