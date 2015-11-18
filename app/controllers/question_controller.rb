class QuestionController < ApplicationController
  include Wicked::Wizard
  steps :dad, :mom, :pref, :tel, :hobby

  def show
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    render_wizard
  end

  def update
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    @q.assign_attributes(params[:questionnaire])

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = @q.send(param)
    end

    case step
    when :dad
      if user_signed_in?
        father = current_user.people.father.first || Person.new
        father.user = current_user
        father.assign_attributes(relation: 0,
                                 birthday: @q.dad,
                                 location: @q.pref_id)
        father.save
      end
    when :mom
      if user_signed_in?
        mother = current_user.people.mother.first || Person.new
        mother.user = current_user
        mother.assign_attributes(relation: 1,
                                 birthday: @q.mom,
                                 location: @q.pref_id)
        mother.save
      end
    end

    render_wizard @q
  end

  def finish_wizard_path
    home_path
  end

  def destroy_all
    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.delete(param)
    end
    redirect_to question_path(:dad)
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3)
  end
end
