class TopController < ApplicationController
  def index
    if cookies.signed[:dad] && params[:commit] != "再設定" then
      redirect_to("/welcome?dad="<<cookies.signed[:dad]<<"&mom="<<cookies.signed[:mom]<<"&pref_id="<<cookies.signed[:pref_id])
    end
  end
end
