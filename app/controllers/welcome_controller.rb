# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  helper_method :smartphone?

  # POST /
  def top

    @questionnaire = Questionnaire.new
    @questionnaire.assign_attributes(params[:questionnaire])

    # Set cookies
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param]
    end

    # リクエストパラメータから都道府県コードを取得する
    @pref_id = params[:pref_id]

    remind_months_ago = Oyaco::Application.config.remind_months_ago
    @topics = []

    father = Person.new
    father.assign_attributes(relation: 0, 
                             birthday: @questionnaire.dad, 
                             location: params[:pref_id])
    mother = Person.new
    mother.assign_attributes(relation: 1, 
                             birthday: @questionnaire.mom, 
                             location: params[:pref_id])

    [father, mother].each do |person|
      if person.next_birthday < Date.today.months_since(remind_months_ago)
        @topics.push(
          title: "もうすぐ #{person.name} の #{person.age + 1} 歳の誕生日（#{person.next_birthday.strftime('%-m月%e日')})",
          comment: 'こんなプレゼントはいかがですか？',
          items: RakutenWebService::Ichiba::Item.ranking(age: person.rakuten_age, sex: person.gender))
      end
    end

    # 祝日関連の話題
    @holidays = Holiday.where(date: Date.today..Date.today.months_since(remind_months_ago)).order('date')
    @holidays.each do |holiday|
      @topics.push(
        title: holiday.date.strftime('%Y年%-m月%e日') + 'は' + holiday.name,
        comment: get_comment_by_event(holiday),
        items: RakutenWebService::Ichiba::Item.search(keyword: holiday.name),
        message: get_message_by_event(holiday))
    end

    @pref_name = PrefName.get_pref_name(@pref_id)
    @warnings = LocalInfo.get_weather_warnings(@pref_id)
    @message = MessageGenerator.new(@warnings).generate

    # Google search
    @googlenews = LocalInfo.get_local_news(@pref_name)

    # 趣味
    @hobbys = []
    [:hobby, :hobby2, :hobby3].each do |param|
      hobby_input = params[param]
      if hobby_input > ''
        @hobbys.push(
          name: hobby_input,
          news: LocalInfo.get_hobby_news(hobby_input)
        )
      end
    end

    # 電話番号
    @tel = params[:tel]
  end

  private

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
    else
      '帰省しましょう。お土産はどうですか'
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

  def smartphone?
    ua = request.user_agent
    return true if ua.match(/iPhone/i)
    return true if ua.match(/Android/i) && ua.match(/Mobile/i)
    false
  end
end
