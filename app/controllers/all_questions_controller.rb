class AllQuestionsController < ApplicationController
  def index
    if user_signed_in?
      @q = Questionnaire.new
      @q.restore_attributes_from_cookies(cookies)
    else
      redirect_to new_user_session_path
    end
  end

  def create
    redirect_to home_path
  end
end
