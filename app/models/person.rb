class Person < ActiveRecord::Base
  belongs_to :user

  include JpPrefecture
  jp_prefecture :prefecture_code

  enum relation: %i(father mother)

  def location_name
    JpPrefecture::Prefecture.find(location).name
  end

  def age
    (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10_000
  end

  def rakuten_age # 10, 20, 30, 40, 50
    age_r = age.round(-1)
    age_r = 50 if age_r > 50
    age_r = 10 if age_r == 0
    age_r
  end

  def friendly_name
    return self.name ||
      case self.relation
      when "father"
        "お父さん"
      when "mother"
        "お母さん"
      else
        "名無しさん"
      end
  end

  def next_birthday
    # FIXME: うるう年を考慮していない
    next_birthday = Date.new(Date.today.year, birthday.month, birthday.day)
    if next_birthday < Date.today # including today
      next_birthday = Date.new(Date.today.year + 1, birthday.month, birthday.day)
    end
    next_birthday
  end

  def gender
    case self.relation
    when "father"
      0
    when "mother"
      1
    else
      0
    end
  end
end
