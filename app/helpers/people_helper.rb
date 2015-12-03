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
end
