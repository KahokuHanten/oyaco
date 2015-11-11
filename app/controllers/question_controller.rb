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
    @questionnaire.restore_attributes_from_cookies(cookies) 
    case step
    when :mom
      @questionnaire.assign_attributes(params[:questionnaire])
    when :pref
      @questionnaire.assign_attributes(params[:questionnaire])
    end
    # Set cookies
    if !@questionnaire.dad.blank? then
      params[:dad] = @questionnaire.send(:dad).try(:strftime, '%Y-%m-%d')
    end
    if !@questionnaire.mom.blank? then
      params[:mom] = @questionnaire.send(:mom).try(:strftime, '%Y-%m-%d')
    end

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      if params.has_key?(param) then
        cookies.signed[param] = params[param]
      end
    end
    if !params[:hobby].blank?||!params[:hobby2].blank?||!params[:hobby3].blank?
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
