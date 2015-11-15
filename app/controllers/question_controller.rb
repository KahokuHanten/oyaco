class QuestionController < ApplicationController
  include Wicked::Wizard
  steps :dad, :mom, :pref, :tel, :hobby
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
    unless @questionnaire.dad.blank?
      params[:dad] = @questionnaire.send(:dad).try(:strftime, '%Y-%m-%d')
    end

    unless @questionnaire.mom.blank?
      params[:mom] = @questionnaire.send(:mom).try(:strftime, '%Y-%m-%d')
    end

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param] if params.key?(param)
    end

    if !params[:hobby].blank? || !params[:hobby2].blank? || !params[:hobby3].blank?
      save_birthday()
      return redirect_to home_path
    end
    render_wizard
  end

  def destroy_all
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.delete(param)
    end
    redirect_to question_path(:dad)
  end

  def finish_wizard_path
    home_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def save_birthday
    if user_signed_in? then
      p = Person.new
      p.save_current_user_birthday(current_user.id,cookies.signed[:dad],cookies.signed[:mom])
    end
  end
end
