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
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    @q.assign_attributes(params[:questionnaire])

    [:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = @q.send(param)
    end

    father = current_user.people.father.first || Person.new
    father.user = current_user
    father.assign_attributes(relation: Person.relations[:father],
                             birthday: @q.dad,
                             location: @q.pref_id)
    father.save

    mother = current_user.people.mother.first || Person.new
    mother.user = current_user
    mother.assign_attributes(relation: Person.relations[:mother],
                             birthday: @q.mom,
                             location: @q.pref_id)
    mother.save

    redirect_to home_path
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3)
  end
end
