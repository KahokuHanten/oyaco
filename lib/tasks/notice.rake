namespace :chrome_notice do
  desc "祝日と誕生日の当日、７日前、１４日前、２１日前、２８日前に、ブラウザへのプッシュ通知を実施"
  task :notice_task => :environment do
    holidays = Holiday.notice
    if holidays.count > 0
      users = User.where("subscription_id is not null")
      users.each do |user|
        res = BrowserNotice.chrome_notice(user.subscription_id)
        puts 'holiday', user.name, user.email, user.subscription_id, res.code, res.msg, res.body
      end
    else
      Person.notice.each do |person|
        if person.user.subscription_id.present?
          res = BrowserNotice.chrome_notice(person.user.subscription_id)
          puts 'birthday', person.user.name, person.user.email, person.user.subscription_id, res.code, res.msg, res.body
        end
      end
    end
  end
end
