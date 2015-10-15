json.array!(@people) do |person|
  json.extract! person, :id, :user_id, :name, :relation, :birthday, :location
  json.url person_url(person, format: :json)
end
