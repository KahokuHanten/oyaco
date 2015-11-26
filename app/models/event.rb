class Event < ActiveRecord::Base
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
end
