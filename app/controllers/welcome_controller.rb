# -*- coding: utf-8 -*-
class WelcomeController < ApplicationController
  # GET /
  def top
    #イベント情報の取得
    @events = Event.where('event_date > ?',Date.today).order('event_date')

    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
    end

    

    case Time.now.strftime("%S")[-1]
    when "1" then
       keyword = '敬老の日'
    when "2" then
       keyword = 'おじいちゃん プレゼント'
    when "3" then
       keyword = 'おばあちゃん プレゼント'
    when "4" then
       keyword = '父の日 ギフト'
    when "5" then
       keyword = '母の日 ギフト'
    when "6" then
       keyword = '敬老の日'
    when "7" then
       keyword = 'おじいちゃん プレゼント'
    when "8" then
       keyword = 'おばあちゃん プレゼント'
    when "9" then
       keyword = '父の日 ギフト'
    else
       keyword = '母の日 ギフト'
    end

    @items = RakutenWebService::Ichiba::Item.search(:keyword => keyword)
  end
end
