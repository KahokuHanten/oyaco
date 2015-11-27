class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :people, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
