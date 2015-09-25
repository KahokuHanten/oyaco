require 'rakuten_web_service'
require 'uri'

class RankingPageController < ApplicationController

  # GET /rankings
  def index
  
    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
    end
  
    @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 50, :sex => 0)
  end

end
