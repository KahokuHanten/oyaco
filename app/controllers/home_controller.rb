class HomeController < ApplicationController
  #  before_action :authenticate_user!, only: :show

  def disclaimer
  end

  def index
    return redirect_to home_path if user_signed_in?
  end

  def show
    return redirect_to root_path if !user_signed_in? && !cookies.signed[:pref_code]

    @user = current_user
    @event = Event.new
    questionnaire = Questionnaire.new
    questionnaire.restore_attributes_from_cookies(cookies)
    build_topics(questionnaire) if questionnaire.present?
  end

  private

  def build_topics(questionnaire)
    pref_code = questionnaire.pref_code

    @topics = []

    # Guest
    unless user_signed_in?
      father = Person.new
      father.assign_attributes(relation: Person.relations[:father],
                               birthday: questionnaire.dad,
                               location: questionnaire.pref_code)
      mother = Person.new
      mother.assign_attributes(relation: Person.relations[:mother],
                               birthday: questionnaire.mom,
                               location: questionnaire.pref_code)

      [father, mother].each do |person|
        next unless person.present?
        if person.birthday?
          @topics.push(
            type: :birthday,
            date: person.next_birthday,
            title: "#{person.next_birthday.strftime('%Y年%-m月%e日')} は #{person.friendly_name} の #{person.age + 1} 歳の誕生日",
            comment1: (get_comment_by_age(person.age + 1)).html_safe,
            comment2: birthday_comment(person),
            comment3: 'こんなプレゼントはいかがですか？',
            image: EventData.find_by_name("誕生日").try(:image),
            item:  Present.item(person))
        end
      end
    end

    # 祝日関連の話題
    holidays = Holiday.soon
    holidays.each do |holiday|
      @topics.push(
        type: :holiday,
        date: holiday.date,
        title: holiday.date.strftime('%Y年%-m月%e日') + 'は' + holiday.name,
        name: holiday.name,
        comment1: EventData.find_by_name(holiday.name).try(:comment),
        wikipedia: EventData.find_by_name(holiday.name).try(:wikipedia),
        item: Present.item(holiday),
        message: EventData.find_by_name(holiday.name).try(:message),
        image: EventData.find_by_name(holiday.name).try(:image))
    end

    # ユーザーイベント
    if user_signed_in?
      current_user.events.each do |event|
        if event.birth?
          type = :birthday
          date = event.next_date
          title = "#{event.next_date.strftime('%Y年%-m月%e日')} は #{event.person.friendly_name} の #{event.person.age + 1} 歳の誕生日"
          comment1 = (get_comment_by_age(event.person.age + 1)).html_safe
          comment2 = birthday_comment(event.person)
          comment3 = 'こんなプレゼントはいかがですか？'
          image = EventData.find_by_name("誕生日").try(:image)
          item =  Present.item(event.person)
        else
          type = :user
          date = event.date
          title = event.next_date.strftime('%Y年%-m月%e日') + 'は' + event.name
          image = EventData.find_by_name(event.name).try(:image)
        end

        @topics.push(
          type: type, event: event, date: date, title: title, name: event.name,
          image: image, item: item,
          comment1: comment1,
          comment2: comment2,
          comment3: comment3)
      end
    end

    # 日付でソート
    @topics.sort! do |a, b|
      a[:date] <=> b[:date]
    end

    # Local
    if pref_code.present?
      @pref_code = pref_code
      @pref_name = view_context.pref_code2name(pref_code)
      @warnings = News.weather_warnings(pref_code)
      @message = MessageGenerator.new(@warnings).generate
      @googlenews = News.local(@pref_name)
    end

    # 趣味
    @hobbys = []
    [:hobby, :hobby2, :hobby3].each do |hobby|
      hobby_name = questionnaire.send(hobby)
      if hobby_name.present?
        @hobbys.push(name: hobby_name, news: News.hobby(hobby_name))
      end
    end

    # 電話番号
    @tel = questionnaire.tel || ''
  end

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
