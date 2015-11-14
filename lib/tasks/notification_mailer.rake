namespace :notice do
  desc "メール通知する"
  task :email => :environment do
    User.all.each do |user|
      if user.email.present?
        puts "send to " + user.email
        NotificationMailer.sendmail(user).deliver
      end
    end
  end
end
