class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :attendances, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :attendances, source: :attendee

  validates :name, presence: true
  validates :date, presence: true

  scope :past_events, -> { where(date: ..Date.yesterday).order(date: :desc) }
  scope :upcoming_events, -> { where(date: Date.today..).order(date: :asc) }
end
