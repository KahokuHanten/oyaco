class Present
  def self.cached_request(param)
    needed = "affiliateUrl,mediumImageUrls"
    case param
    when Holiday
      holiday = param
      Rails.cache.fetch "p_#{holiday.name}", :expires_in => 24.hours do
        items = RakutenWebService::Ichiba::Item.search(keyword: holiday.name,
                  elements: needed, hits: 1)
        item = items.first
        {url: item["affiliateUrl"], imageUrl: item['mediumImageUrls'][0]['imageUrl']}
      end
    when Person
      person = param
      Rails.cache.fetch "person_#{person.rakuten_age}_#{person.gender}", :expires_in => 24.hours do
        items = RakutenWebService::Ichiba::Item.ranking(age: person.rakuten_age, sex: person.gender,
                  elements: needed)
        item = items.first
        {url: item["affiliateUrl"], imageUrl: item['mediumImageUrls'][0]['imageUrl']}
      end
    else
      nil
    end
  end
end
