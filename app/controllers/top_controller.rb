class TopController < ApplicationController
  def index
    return redirect_to welcome_path if user_signed_in?
  end
end
