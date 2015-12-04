class QuestionController < ApplicationController
  include Wicked::Wizard
  #steps :dad, :mom, :pref, :tel, :hobby
  steps :dad, :mom, :pref, :hobby
  def show
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    render_wizard
  end

  def update
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    @q.assign_attributes(params[:questionnaire])

    [:dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = @q.send(param)
    end

    case step
    when :dad
      if user_signed_in?
        father = current_user.people.father.first || Person.new
        father.user = current_user
        father.assign_attributes(relation: Person.relations[:father],
                                 birthday: @q.dad,
                                 location: @q.pref_code)
        father.save
        if (e = current_user.events.find_by(person_id: father.id))
          e.update(name: "お父さんの誕生日", date: @q.dad, kind: :birth, person_id: father.id)
        else
          current_user.events.create(name: "お父さんの誕生日", date: @q.dad, kind: :birth, person_id: father.id)
        end
      end
    when :mom
      if user_signed_in?
        mother = current_user.people.mother.first || Person.new
        mother.user = current_user
        mother.assign_attributes(relation: Person.relations[:mother],
                                 birthday: @q.mom,
                                 location: @q.pref_code)
        mother.save
        if (e = current_user.events.find_by(person_id: mother.id))
          e.update(name: "お母さんの誕生日", date: @q.mom, kind: :birth, person_id: mother.id)
        else
          current_user.events.create(name: "お母さんの誕生日", date: @q.mom, kind: :birth, person_id: mother.id)
        end
      end
    end
    render_wizard @q
  end

  def finish_wizard_path
    home_path
  end

  def destroy_all
    [:dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.delete(param)
    end
    redirect_to question_path(:dad)
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3)
  end
end
