class NotificationMailer < ApplicationMailer
  def event_mail(user, events)
    @user = user
    @events = events
    mail to: @user.email, subject: "OYACOからのお知らせ"
  end
end
