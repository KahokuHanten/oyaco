class TopController < ApplicationController
  def index
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies.signed)
  end
end
