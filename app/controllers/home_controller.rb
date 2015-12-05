class HomeController < ApplicationController
  #  before_action :authenticate_user!, only: :show
  include PeopleHelper
  include NewsHelper
  include ApplicationHelper

  def disclaimer
  end

  def index
    return redirect_to home_path if user_signed_in?
  end

  def show
    return redirect_to root_path if !user_signed_in? && !cookies.signed[:pref_code]

    @user = current_user
    @event = Event.new
    @note = Note.new
    questionnaire = Questionnaire.new
    questionnaire.restore_attributes_from_cookies(cookies)
    build_topics(questionnaire) if questionnaire.present?
    if user_signed_in?
      @user.point += 10 
      @user.save
    end
  end

  private

  def build_topics(questionnaire)
    pref_code = questionnaire.pref_code

    @topics = []

    # Guest
    unless user_signed_in?
      father = Person.new
      father.assign_attributes(relation: Person.relations[:father],
                               birthday: questionnaire.dad,
                               location: questionnaire.pref_code)
      mother = Person.new
      mother.assign_attributes(relation: Person.relations[:mother],
                               birthday: questionnaire.mom,
                               location: questionnaire.pref_code)

      [father, mother].each do |person|
        next unless person.present?
        if person.birthday?
          @topics.push(
            type: :birthday,
            date: person.next_birthday,
            title: "#{format_date(person.next_birthday)} は #{person.friendly_name} の #{person.age + 1} 歳の誕生日",
            comment1: (get_comment_by_age(person.age + 1)).html_safe,
            comment2: birthday_comment(person),
            comment3: 'こんなプレゼントはいかがですか？',
            image: EventData.find_by_name("誕生日").try(:image),
            item:  Present.item(person))
        end
      end
    end

    # 祝日関連の話題
    holidays = Holiday.soon
    holidays.each do |holiday|
      @topics.push(
        type: :holiday,
        date: holiday.date,
        title: format_date(holiday.date) + 'は' + holiday.name,
        name: holiday.name,
        comment1: EventData.find_by_name(holiday.name).try(:comment),
        wikipedia: EventData.find_by_name(holiday.name).try(:wikipedia),
        item: Present.item(holiday),
        message: EventData.find_by_name(holiday.name).try(:message),
        image: EventData.find_by_name(holiday.name).try(:image))
    end

    # ユーザーイベント
    if user_signed_in?
      current_user.events.each do |event|
        if event.birth?
          type = :birthday
          title = "#{format_date(event.next_date)} は #{event.person.friendly_name} の #{event.person.age + 1} 歳の誕生日"
          comment1 = (get_comment_by_age(event.person.age + 1)).html_safe
          comment2 = birthday_comment(event.person)
          comment3 = 'こんなプレゼントはいかがですか？'
          image = EventData.find_by_name("誕生日").try(:image)
          item =  Present.item(event.person)
        else
          type = :user
          comment1 = event.next_times.to_s + '回目の記念日です。' unless event.next_times == 0
          title = "#{format_date(event.next_date)}は #{event.name}"
          image = EventData.find_by_name(event.name).try(:image)
        end
        note = event.notes.last.try(:body)
        note_image = event.notes.last.try(:image)

        @topics.push(
          id: event.id,
          type: type, event: event, date: event.next_date, title: title, name: event.name,
          image: image, item: item,
          comment1: comment1, comment2: comment2, comment3: comment3,
          note: note, note_image: note_image)
      end
    end

    # 日付でソート
    @topics.sort! do |a, b|
      a[:date] <=> b[:date]
    end

    # Local
    if pref_code.present?
      @pref_code = pref_code
      @pref_name = view_context.pref_code2name(pref_code)
      warnings = News.weather_warnings(pref_code)
      @warning_comment = warning_comment(warnings)
      @googlenews = News.local(@pref_name)
    end

    # 趣味
    @hobbys = []
    [:hobby, :hobby2, :hobby3].each do |hobby|
      hobby_name = questionnaire.send(hobby)
      if hobby_name.present?
        @hobbys.push(name: hobby_name, news: News.hobby(hobby_name))
      end
    end

    # 電話番号
    @tel = questionnaire.tel || ''
  end
end
