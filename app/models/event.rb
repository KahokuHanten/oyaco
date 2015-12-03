class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  has_many :notes, dependent: :destroy

  enum kind: %i(birth death wedding annual onetime)

  validates :name, presence: true
  validates :date, presence: true

  def next_date  # FIXME: うるう年を考慮していない
    return self.date if Date.current <= self.date # まだ一度も来ていない
    next_date = Date.new(Date.current.year, self.date.month, self.date.day)
    if next_date < Date.current # including today
      next_date = Date.new(Date.current.year + 1, self.date.month, self.date.day)
    end
    next_date
  end

  def next_times # 初めてが0、その次が1=1回目の記念日
    return 0 if Date.current <= self.date # まだ一度も来ていない
    next_times = Date.current.year - self.date.year
    next_date = Date.new(Date.current.year, self.date.month, self.date.day)
    if next_date < Date.current # including today
      # すでに今年は過ぎているので、翌年に
      next_date = Date.new(Date.current.year + 1, self.date.month, self.date.day)
      next_times += 1
    end
    next_times
  end

  def self.notification_filter(events)
    notice_dates = []
    (0..4).each do |i|
      notice_dates.push(Date.current.days_since(i * 7))
    end
    filtered = []
    events.each do |e|
      filtered.push(e) if notice_dates.include?(e.next_date)
    end
    filtered
  end
end
