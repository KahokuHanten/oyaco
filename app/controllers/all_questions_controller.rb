class AllQuestionsController < ApplicationController
  def index
    if user_signed_in?
      @q = Questionnaire.new
      @q.restore_attributes_from_db(cookies, current_user)
binding.pry
      if (e = current_user.events.find_by(kind: 2))
        @q.wedding = e.date
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @q = Questionnaire.new
    @q.restore_attributes_from_cookies(cookies)
    @q.assign_attributes(params[:questionnaire])

    [:dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3].each do |param|
      cookies.signed[param] = @q.send(param)
    end

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

    if @q.wedding.present?
      if (e = current_user.events.find_by(kind: 2))
        e.update(name: "親の結婚記念日", date: @q.wedding, kind: :wedding)
      else
        current_user.events.create(name: "親の結婚記念日", date: @q.wedding, kind: :wedding)
      end
    end

    redirect_to home_path
  end

  private
  def questionnaire_params
    params.require(:questionnaire).permit(:dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3)
  end
end
