class Holiday < ActiveRecord::Base
  scope :soon, -> { where(date: Date.today..Date.today.months_since(Oyaco::Application.config.remind_months_ago)).order('date') }
end
