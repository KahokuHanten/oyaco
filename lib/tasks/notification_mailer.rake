namespace :notice do
  desc "メール通知する"
  task :email => :environment do
    holidays = Holiday.notice
    User.find_each do |user|
      if user.email.present? && !user.email.include?("@example.com")
        # check events to be notified
        events = Event.notification_filter(user.events)
        if holidays.present? || events.present?
          NotificationMailer.mail_notice(user, events, holidays).deliver
        end
      end
    end
  end
end
