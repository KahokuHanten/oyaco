class TopController < ApplicationController
  def index
    if cookies.signed[:dad] && !params[:retry]
      redirect_to(controller: 'welcome', action: 'top',
                  dad: cookies.signed[:dad],
                  mom: cookies.signed[:mom],
                  pref_id: cookies.signed[:pref_id],
                  tel: cookies.signed[:tel])
    end
  end
end
