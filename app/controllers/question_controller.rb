class QuestionController < ApplicationController
  include Wicked::Wizard
  steps :dad, :mom, :pref,:tel,:hobby
  before_filter :set_locale

  def show
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    render_wizard
  end
  
  def update
    @questionnaire = Questionnaire.new
    case step
    when :dad
      @questionnaire.assign_attributes(params[:questionnaire])
    when :mom
      @questionnaire.assign_attributes(params[:questionnaire])
    end
    # Set cookies
    [:dad, :mom].each do |field|
      params[field] = @questionnaire.send(field).try(:strftime, '%Y-%m-%d')
    end
logger.debug("hello")
logger.debug(params)

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param]
    end
    if step==:hobby && (!params[:hobby].blank?||!params[:hobby2].blank?||!params[:hobby3].blank?)
      return redirect_to welcome_path 
    end
    render_wizard
  end
 
  def finish_wizard_path
    return  welcome_path
  end
  
  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end


end
