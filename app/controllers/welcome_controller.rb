class WelcomeController < ApplicationController
  # GET /
  def top
    # Set cookies
    [:dad, :mom, :pref_id, :tel].each do |param|
      cookies.signed[param] = params[param]
    end

    # 楽天API呼出し用のIDを環境変数から取得する
    RakutenWebService.configuration do |c|
      c.application_id = ENV['APPID']
      c.affiliate_id = ENV['AFID']
    end

    # リクエストパラメータから都道府県コードを取得する
    @pref_id = params[:pref_id]

    remind_months_ago = Oyako::Application.config.remind_months_ago

    # 誕生日の話題
    @topics = []

    # FIXME: need to create model
    # 父
    birthdate = params[:dad]
    age = get_age(birthdate)
    age_r = get_rakuten_age(age)
    next_birthday = get_next_birthday(birthdate)
    if next_birthday < Date.today.months_since(remind_months_ago)
      @topics.push(
        title: 'もうすぐお父さんの' + (age + 1).to_s + '歳の誕生日（' + next_birthday.strftime('%-m月%e日') + ')',
        comment: 'こんなプレゼントはいかがですか？',
        items: RakutenWebService::Ichiba::Item.ranking(age: age_r, sex: 0))
    end

    # 母  FIXME: DRY
    birthdate = params[:mom]
    age = get_age(birthdate)
    age_r = get_rakuten_age(age)
    next_birthday = get_next_birthday(birthdate)
    if next_birthday < Date.today.months_since(remind_months_ago)
      @topics.push(
        title: 'もうすぐお母さんの' + (age + 1).to_s + '歳の誕生日（' + next_birthday.strftime('%-m月%e日') + ')',
        comment: 'こんなプレゼントはいかがですか？',
        items: RakutenWebService::Ichiba::Item.ranking(age: age_r, sex: 1))
    end

    # 祝日関連の話題
    @holidays = Holiday.where(holiday_date: Date.today..Date.today.months_since(remind_months_ago)).order('holiday_date')
    @holidays.each do |holiday|
      @topics.push(
        title: holiday.holiday_date.strftime('%Y年%-m月%e日') + 'は' + holiday.holiday_name,
        comment: get_comment_by_event(holiday),
        items: RakutenWebService::Ichiba::Item.search(:keyword => holiday.holiday_name),
        message: get_message_by_event(holiday))
    end

    @pref_name = PrefName.get_pref_name(@pref_id)
    @warnings = LocalInfo.get_weather_warnings(@pref_id)
    @message = MessageGenerator.new(@warnings).generate

    # Google search
    @googlenews = LocalInfo.get_google_news(@pref_name)

    # 電話番号
    @tel = params[:tel]
  end

  private
  def get_age(birthdate)
    age = ((Date.today.strftime('%Y%m%d').to_i -
            Date.strptime(birthdate).strftime('%Y%m%d').to_i) / 10_000)
  end

  def get_rakuten_age(age)
    age_r = age.round(-1)
    age_r = 50 if age_r > 50
    age_r = 10 if age_r == 0
    age_r
  end

  def get_next_birthday(birthdate)
    birthday = Date.strptime(birthdate)
    next_birthday = Date.new(Date.today.year, birthday.month, birthday.day)
    if next_birthday < Date.today
      next_birthday = Date.new(Date.today.year + 1, birthday.month, birthday.day)
    end
    next_birthday
  end

  def get_comment_by_event(holiday)
    case holiday.holiday_name
    when /母/
      "カーネーションと一緒にプレゼントを贈りましょう"
    when /父/
      "父の日に贈り物はどうでしょう"
    when /春|秋/
      "お墓参りに帰省しましょう"
    when /敬老/
      "おじいさん、おばあさんにプレゼントを贈りましょう"
    else
      "帰省しましょう。お土産はどうですか"
    end
  end

  def get_message_by_event(holiday)
    prefix = ""
    case holiday.holiday_name
    when /母/
      "いつも家事をしてくれてありがとう"
    when /父/
      "お仕事いつもやってやってくれてありがとう"
    when /春|秋/
      "ご先祖様ありがとう"
    when /敬老/
      "おじいちゃん、おばあちゃん、長生きしてね"
    else
      nil
    end
  end
end
