# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  # GET /welcome
  def show
    return redirect_to question_path unless cookies.signed[:pref_id]

    # get params from cookies
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      params[param] = cookies.signed[param]
    end
    build_topics(params)
    render :top
  end

  # POST /welcome
  def top
    @questionnaire = Questionnaire.new
    @questionnaire.assign_attributes(params[:questionnaire])

    # Set cookies
    [:dad, :mom].each do |field|
      params[field] = @questionnaire.send(field).try(:strftime, '%Y-%m-%d')
    end

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param]
    end

    build_topics(params)
    render :top
  end

  # DELETE /welcome
  def clear
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.delete(param)
    end
    redirect_to question_path
  end

  # POST /welcome/save_subscription_id
  def save_subscription_id
    subscription_id = params[:subscription_id]
    if current_or_guest_user
      current_or_guest_user.update_attribute(:subscription_id, subscription_id)
    end
    render nothing: true
  end

  # POST /welcome/clear_subscription_id
  def clear_subscription_id
    if current_or_guest_user
      current_or_guest_user.update_attribute(:subscription_id, nil)
    end
    render nothing: true
  end

  private
  def build_topics(params)
    # リクエストパラメータから都道府県コードを取得する
    @pref_id = params[:pref_id]

    remind_months_ago = Oyaco::Application.config.remind_months_ago
    @topics = []

    father = Person.new
    father.assign_attributes(relation: 0,
                             birthday: params[:dad],
                             location: params[:pref_id])
    mother = Person.new
    mother.assign_attributes(relation: 1,
                             birthday: params[:mom],
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
        items: (RakutenWebService::Ichiba::Item.search(keyword: holiday.name) unless holiday.name == "元日"),
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
      if hobby_input.present?
        @hobbys.push(
          name: hobby_input,
          news: LocalInfo.get_hobby_news(hobby_input)
        )
      end
    end

    # 電話番号
    @tel = (params[:tel] ||= '')
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
