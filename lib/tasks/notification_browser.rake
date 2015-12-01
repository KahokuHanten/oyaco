namespace :notice do
  desc "ブラウザにプッシュ通知する"
  task :browser => :environment do
    holidays = Holiday.notice
    users = User.where("subscription_id is not null")
    users.each do |user|
      # check events to be notified
      events = Event.notification_filter(user.events)
      if holidays.present? || events.present?
        res = NotificationBrowser.chrome_notice(user.subscription_id)
        puts 'notice', user.name, user.email, user.subscription_id, res.code, res.msg, res.body
      end
    end
  end
end
