class Holiday < ActiveRecord::Base
  scope :soon, -> { where(date: Date.today..Date.today.months_since(Oyaco::Application.config.remind_months_ago)).order('date') }

  notice_dates = []
  (0..4).each do |i|
    notice_dates.push(Date.current.days_since(i * 7))
  end
  scope :notice, -> { where("date IN (?)", notice_dates) }
end
