class NotificationMailer < ApplicationMailer
  add_template_helper(PeopleHelper)

  def mail_notice(user, events, holidays)
    @user = user
    @events = events
    @holidays = holidays
    mail to: @user.email, subject: "OYACOからのお知らせ"
  end
end
