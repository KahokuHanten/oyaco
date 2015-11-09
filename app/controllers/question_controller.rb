class QuestionController < ApplicationController
  def new
    current_or_guest_user
    @questionnaire = Questionnaire.new
    render :index
  end

  def edit
    @questionnaire = Questionnaire.new
    @questionnaire.restore_attributes_from_cookies(cookies)
    render :index
  end

  def destroy
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.delete(param)
    end
    redirect_to new_question_path
  end

  def create
    @questionnaire = Questionnaire.new
    @questionnaire.assign_attributes(params[:questionnaire])

    # Set cookies
    [:dad, :mom].each do |field|
      params[field] = @questionnaire.send(field).try(:strftime, '%Y-%m-%d')
    end

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = params[param]
    end
    redirect_to home_path
  end
end
