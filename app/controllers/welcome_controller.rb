class WelcomeController < ApplicationController
  # GET /
  def top

    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
    end

    @rankings = RakutenWebService::Ichiba::Item.ranking(:age => 50, :sex => 0)
  end
end
