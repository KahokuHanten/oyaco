require 'open-uri'
require 'nokogiri'

class LocalInfo
  WW_URL = 'http://weather.livedoor.com/forecast/rss/warn/'

  def self.get_weather_warnings(id)
    doc = ""
    messages = []
    pref = ""
    if id == "01" then
      pref = "01b" # FIXME
    else
      pref = id
    end

    doc = Nokogiri::XML(open(WW_URL + pref + '.xml').read)
    doc.xpath('//item/description').each {|node|
      messages.push(node.text) unless /livedoor/.match(node.text)
    }
    messages
  end
end
