class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events, class_name: 'Event', foreign_key: 'user_id'
  has_many :event_attendees
  has_many :attended_events, through: :event_attendees, source: :event

  validates :name, presence: true
  validates :email, presence: true
  validates :username, presence: true
end
