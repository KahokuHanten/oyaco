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
end
