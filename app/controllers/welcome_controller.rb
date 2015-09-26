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

    # @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 50, :sex => 0)
    @items = RakutenWebService::Ichiba::Item.search(:keyword => '敬老の日')
  end
end
