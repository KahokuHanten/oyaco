module PeopleHelper
  def birthday_comment(person)
    return unless person.birthday?
    if person.relation == "father"
      category = '日本人男性'
    else
      category = '日本人女性'
    end

    remaining_time_to_life_span = person.remaining_time_to_life_span
    if remaining_time_to_life_span == 0
      birthday_comment = "今回では#{category}の平均寿命（ #{person.average_life_span} 歳）になります。"
    elsif remaining_time_to_life_span < 0
      birthday_comment = "#{category}の平均寿命は#{person.average_life_span} 歳です。ご長寿ですね。 "
    elsif remaining_time_to_life_span > 0
      birthday_comment = "あと#{remaining_time_to_life_span}年で、#{category}の平均寿命（#{person.average_life_span}）になります。"
    end
    return birthday_comment
  end

  def get_comment_by_age(age)
    case age
    when 61
      '61歳は還暦です。【出典・由来】干支が60年後に出生時の干支に還って（かえって）くるため。'
    when 70
      '70歳は古希です。【出典・由来】「人生七十、古来稀なり」の詩（杜甫「曲江」）より。'
    when 77
      '77歳は喜寿です。【出典・由来】「喜」の草体が七十七のように見えるため。'
    when 80
      '80歳は傘寿です。【出典・由来】「傘」の字を略すと八十に見えるため。'
    when 88
      '88歳は米寿です。【出典・由来】「米」の字が八十八と分解できるため。'
    when 90
      '90歳は卒寿です。【出典・由来】「卒」の略字（卆）が九十と分解できるため。'
    when 99
      '99歳は白寿です。【出典・由来】「百」の字から一をとると白になる事から。'
    else
      ''
    end
  end

  def wedding_name(num)
    case num
    when 1
      "紙婚式"
    when 2
      "藁婚式、綿婚式"
    when 3
      "革婚式"
    when 4
      "花実婚式"
    when 5
      "木婚式"
    when 6
      "鉄婚式"
    when 7
      "銅婚式"
    when 8
      "青銅婚式"
    when 9
      "陶器婚式"
    when 10
      "アルミ婚式、錫婚式"
    when 11
      "鋼鉄婚式"
    when 12
      "絹婚式、亜麻婚式"
    when 13
      "レース婚式"
    when 14
      "象牙婚式"
    when 15
      "水晶婚式"
    when 20
      "磁器婚式、陶器婚式"
    when 25
      "銀婚式"
    when 30
      "真珠婚式"
    when 35
      "珊瑚婚式"
    when 40
      "ルビー婚式"
    when 45
      "サファイア婚式"
    when 50
      "金婚式"
    when 55
      "エメラルド婚式"
    when 60
      "ダイヤモンド婚式"
    when 70
      "プラチナ婚式"
    when 75
      "ダイヤと金婚式"
    when 80
      "樫婚式"
    when 85
      "ワイン婚式"
    else
      ''
    end
  end
end
