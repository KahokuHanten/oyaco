class QuestionController < ApplicationController
  include Wicked::Wizard
  steps :dad, :mom, :pref, :tel, :hobby

  def show
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    render_wizard
  end

  def update
#    binding.pry
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
      params[:dad] = @questionnaire.dad.try(:strftime, '%Y-%m-%d')
    end

    unless @questionnaire.mom.blank?
      params[:mom] = @questionnaire.mom.try(:strftime, '%Y-%m-%d')
    end

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param] if params.key?(param)
    end

    # last question
    if !params[:hobby].blank? || !params[:hobby2].blank? || !params[:hobby3].blank?
      save_birthday
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

  def save_birthday
    if user_signed_in?
      father = current_user.people.father.first || Person.new
      father.user = current_user
      father.assign_attributes(relation: 0,
                               birthday: @questionnaire.dad,
                               location: @questionnaire.pref_id)
      father.save
      mother = current_user.people.mother.first || Person.new
      mother.user = current_user
      mother.assign_attributes(relation: 1,
                               birthday: @questionnaire.mom,
                               location: @questionnaire.pref_id)
      mother.save
    end
  end
end
