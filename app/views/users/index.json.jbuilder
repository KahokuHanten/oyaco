json.array!(@users) do |user|
  json.extract! user, :id, :name, :birthday_year, :birthday_month, :birthday_day
  json.url user_url(user, format: :json)
end
