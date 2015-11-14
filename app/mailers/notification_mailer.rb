class NotificationMailer < ApplicationMailer
  default from: "info@oyaco.herokuapp.com"

  def sendmail(user)
    mail to: user.email,
      subject: "OYACOからのお知らせです"
  end
end
