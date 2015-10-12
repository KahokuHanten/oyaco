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

    # 誕生日の話題
    @topics_birthday = []

    # FIXME: need to create model
    # 父
    birthdate = params[:dad]
    age = get_age(birthdate)
    age_r = get_rakuten_age(age)
    next_birthday = get_next_birthday(birthdate)
    if next_birthday - 1.months < Date.today
      @topics_birthday.push(
        title: 'もうすぐお父さんの' + (age + 1).to_s + '歳の誕生日（' + next_birthday.strftime('%-m月%e日') + ') です',
        comment: 'こんなプレゼントはいかがですか？',
        items: RakutenWebService::Ichiba::Item.ranking(age: age_r, sex: 0))
    end

    # 母  FIXME: DRY
    birthdate = params[:mom]
    age = get_age(birthdate)
    age_r = get_rakuten_age(age)
    next_birthday = get_next_birthday(birthdate)
    if next_birthday - 1.months < Date.today
      @topics_birthday.push(
        title: 'もうすぐお母さんの' + (age + 1).to_s + '歳の誕生日（' + next_birthday.strftime('%-m月%e日') + ') です',
        comment: 'こんなプレゼントはいかがですか？',
        items: RakutenWebService::Ichiba::Item.ranking(age: age_r, sex: 1))
    end

    # 警報・注意報の話題
    @pref_name = PrefName.get_pref_name(@pref_id)
    @warnings = LocalInfo.get_weather_warnings(@pref_id)
    @message = MessageGenerator.new(@warnings).generate

    # 祝日関連の話題
    @holidays = Holiday.where('holiday_date > ?', Date.today).order('holiday_date')

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
end
