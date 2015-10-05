# -*- coding: utf-8 -*-
require 'pp'
# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  # GET /
  def top
    #リクエストパラメータから都道府県コードを取得する
    @pref_id = params[:pref_id]
    
    #都道府県コードをもとに都道府県名を取得する
    @pref_name = PrefName.get_pref_name(@pref_id)
    
    #都道府県コードをもとに警報・注意報を取得する
    @warnings = LocalInfo.get_weather_warnings(@pref_id)

    #コメントを作る
    @message = MessageGenerator.new(@warnings).generate

    #祝日情報を取得する
    @holidays = Holiday.where('holiday_date > ?',Date.today).order('holiday_date')

    #Google search
    @googleNews = LocalInfo.get_google_news(@pref_name)

    #楽天API呼出し用のIDを環境変数から取得する
    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
    end
    
    
  end
end
