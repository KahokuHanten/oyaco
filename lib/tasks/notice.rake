task :notice_task => :environment do
  holidays = Holiday.notice
  if holidays.count > 0
    users = User.where("subscription_id is not null")
    users.each do |user|
      uri = URI.parse("https://android.googleapis.com/gcm/send")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "key=" + ENV['GOOGLE_API_KEY']
      payload = {
        'registration_ids': [user.subscription_id]
      }.to_json
      req.body = payload
      res = https.request(req)
      puts user.name, user.email, user.subscription_id, res.code, res.msg, res.body
    end
  end
end
