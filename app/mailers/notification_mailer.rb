class NotificationMailer < ApplicationMailer
  add_template_helper(PeopleHelper)

  def event_mail(user, events, holidays)
    @user = user
    @events = events
    @holidays = holidays
    mail to: @user.email, subject: "OYACOからのお知らせ"
  end
end
