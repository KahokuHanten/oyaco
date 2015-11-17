namespace :notice do
  desc "メール通知する"
  task :email => :environment do
    User.find_each do |user|
      if user.email.present? && !user.email.include?("@example.com")
        # check events to be notified
        events = Holiday.notice
        if events.present?
          NotificationMailer.event_mail(user, events).deliver
        end
      end
    end
  end
end
