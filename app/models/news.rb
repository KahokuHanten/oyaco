class News
  require 'nokogiri'
  require 'open-uri'

  WW_URL = 'http://weather.livedoor.com/forecast/rss/warn/'
  NEWS_NOT_FOUND_MESSAGE = 'に関するニュースは見つかりませんでした'
  API_USAGE_LIMIT = '使用APIの回数制限のため、検索できませんでした'
  JAPAN_FRESH_NEWS = 'jfn'

  class << self
    def weather_warnings(id)
      doc = ''
      messages = []
      pref = '%02d' % id
      if pref == '01'
        pref = '01b' # FIXME
      end

      begin
        doc = Nokogiri::XML(open(WW_URL + pref + '.xml').read)
        doc.xpath('//item/description').each do|node|
          messages.push(node.text) unless /livedoor/.match(node.text)
        end
      rescue
        messages = nil
      end
      messages
    end

    def local(pref_name)
      Rails.cache.fetch "l_#{pref_name}", :expires_in => 24.hours do
        google_cse(pref_name + ' ' + JAPAN_FRESH_NEWS, pref_name)
      end
    end

    def hobby(hobby)
      Rails.cache.fetch "h_#{hobby}", :expires_in => 24.hours do
        hobby_result = google_cse(hobby, hobby)
        hobbys = []
        if !hobby_result.key?('error') && !hobby_result['items'].blank?
          hobby_result['items'].each do |a_news|
            # にっぽんもぎたて便の場合は返却する配列の先頭に挿入する
            if a_news['link'].include?('g=jfn')
              hobbys.unshift(a_news)
            else
              # 通常ニュースの場合は返却配列の末尾に挿入する
              hobbys.push(a_news)
            end
          end
          hobby_result['items'] = hobbys
        end
        hobby_result
      end
    end

    private
    def google_cse(search_text, error_prefix)
      result = GoogleCustomSearchApi.search(search_text)
      error_reason = begin
                      result['error']['errors'][0]['reason']
                    rescue
                      nil
                    end
      if !error_reason.blank? && error_reason == 'dailyLimitExceeded'
        result['error_usage_limit'] = API_USAGE_LIMIT
      elsif result.key?('error') || result['items'].blank?
        result['error'] = error_prefix + NEWS_NOT_FOUND_MESSAGE
      end
      result
    end
  end
end
