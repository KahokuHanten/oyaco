class QuestionController < ApplicationController
  include Wicked::Wizard
  steps :dad, :mom, :pref,:tel,:hobby
  before_filter :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  def show
    user = current_or_guest_user
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    render_wizard
  end
  
  def update
    user = current_or_guest_user
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    render_wizard @questionnaire
  end

end
