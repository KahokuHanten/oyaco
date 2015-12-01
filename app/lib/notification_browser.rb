class NotificationBrowser
  def self.chrome_notice(subscription_id)
    uri = URI.parse("https://android.googleapis.com/gcm/send")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "key=" + ENV['GOOGLE_API_KEY']
    payload = {
      'registration_ids': [subscription_id]
    }.to_json
    req.body = payload
    res = https.request(req)
  end
end
