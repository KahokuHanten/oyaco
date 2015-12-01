class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  has_many :notes, dependent: :destroy

  enum kind: %i(birth death wedding annual onetime)

  validates :name, presence: true
  validates :date, presence: true

  def next_date  # FIXME: うるう年を考慮していない
    next_date = Date.new(Date.current.year, self.date.month, self.date.day)
    if next_date < Date.current # including today
      next_date = Date.new(Date.current.year + 1, self.date.month, self.date.day)
    end
    next_date
  end

  def next_times
    next_date = Date.new(Date.current.year, self.date.month, self.date.day)
    next_times = Date.current.year - self.date.year + 1
    if next_date < Date.current # including today
      next_times += 1
    end
    next_times
  end

  # 当日、7日前、14日前、21日前、28日前に通知
  scope :notice, -> {
    notice_dates = []
    (0..4).each do |i|
      notice_dates.push(Date.current.days_since(i * 7).strftime('%m%d'))
    end
    where("to_char(date, 'mmdd') IN (?)", notice_dates)
  }
end
