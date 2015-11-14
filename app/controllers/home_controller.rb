class HomeController < ApplicationController
#  before_action :authenticate_user!, only: :show

  def index
    return redirect_to home_path if user_signed_in?
  end

  def show
    return redirect_to root_path if !user_signed_in? && !cookies.signed[:pref_id]

    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    if !@questionnaire.blank?
      build_topics(@questionnaire)
    end
  end

  private
  def build_topics(questionnaire)
    # リクエストパラメータから都道府県コードを取得する
    @pref_id = questionnaire.pref_id

     remind_months_ago = Oyaco::Application.config.remind_months_ago
    @topics = []

    father = Person.new
    father.assign_attributes(relation: 0,
                             birthday: questionnaire.dad,
                             location: questionnaire.pref_id)
    mother = Person.new
    mother.assign_attributes(relation: 1,
                             birthday: questionnaire.mom,
                             location: questionnaire.pref_id)

    [father, mother].each do |person|
      if person.birthday?
        if person.next_birthday < Date.today.months_since(remind_months_ago)
          @topics.push(
            title: "もうすぐ #{person.friendly_name} の #{person.age + 1} 歳の誕生日（#{person.next_birthday.strftime('%-m月%e日')})",
            comment: ("こんなプレゼントはいかがですか？<br>" + get_comment_by_age(person.age + 1)).html_safe,
            items: RakutenWebService::Ichiba::Item.ranking(age: person.rakuten_age, sex: person.gender))
        end
      end
    end

    # 祝日関連の話題
    @holidays = Holiday.soon
    @holidays.each do |holiday|
      @topics.push(
        title: holiday.date.strftime('%Y年%-m月%e日') + 'は' + holiday.name,
        comment: get_comment_by_event(holiday),
        items: (RakutenWebService::Ichiba::Item.search(keyword: holiday.name) unless holiday.name == "元日"),
        message: get_message_by_event(holiday))
    end

    # Local
    if @pref_id.present?
      @pref_name = PrefName.get_pref_name(@pref_id)
      @warnings = LocalInfo.get_weather_warnings(@pref_id)
      @message = MessageGenerator.new(@warnings).generate
      @googlenews = LocalInfo.get_local_news(@pref_name)
    end

    # 趣味
    @hobbys = []
    if !questionnaire.hobby.blank? then
      @hobbys.push(
        name: questionnaire.hobby,
        news: LocalInfo.get_hobby_news(questionnaire.hobby)
      )
    end
    if !questionnaire.hobby2.blank? then
      @hobbys.push(
        name: questionnaire.hobby2,
        news: LocalInfo.get_hobby_news(questionnaire.hobby2)
      )
    end
    if !questionnaire.hobby3.blank? then
      @hobbys.push(
        name: questionnaire.hobby3,
        news: LocalInfo.get_hobby_news(questionnaire.hobby3)
      )
    end
    # 電話番号
    @tel = (@questionnaire.tel ||= '')
  end

  def get_comment_by_event(holiday)
    case holiday.name
    when /母/
      'カーネーションと一緒にプレゼントを贈りましょう'
    when /父/
      '父の日に贈り物はどうでしょう'
    when /春|秋/
      'お墓参りに帰省しましょう'
    when /敬老/
      'おじいさん、おばあさんにプレゼントを贈りましょう'
    when /元日/
      '帰省しましょう'
    end
  end

  def get_message_by_event(holiday)
    case holiday.name
    when /母/
      'お母さん。いつもありがとう。いつまでも元気で長生きしてください。'
    when /父/
      'お父さん。いつもありがとう。いつまでも元気で長生きしてください。'
    when /春|秋/
      'ご先祖様ありがとう'
    when /敬老/
      # "おじいちゃん、おばあちゃん、長生きしてね"
    end
  end
end

def get_comment_by_age(age)
  case age
  when 61
    '61歳は還暦です。【出典・由来】干支が60年後に出生時の干支に還って（かえって）くるので。'
  when 70
    '70歳は古希です。【出典・由来】「人生七十、古来稀なり」の詩（杜甫「曲江」）より。'
  when 77
    '77歳は喜寿です。【出典・由来】「喜」の草体が七十七のように見えるため。'
  when 80
    '80歳は傘寿です。【出典・由来】「傘」の略字（仐）が八十と分解できるため。'
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
