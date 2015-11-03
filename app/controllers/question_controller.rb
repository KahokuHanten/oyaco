class QuestionController < ApplicationController
  def index
    user = current_or_guest_user
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
  end
end
