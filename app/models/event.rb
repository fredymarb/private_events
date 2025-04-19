class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :attendances, foreign_key: "attended_event_id"
  has_many :attendees, through: :attendances, source: :attendee

  validates :name, presence: true
  validates :date, presence: true

  def self.past_events
    self.where(date: ...Date.today).order(date: :desc)
  end

  def self.upcoming_events
    self.where(date: Date.today..).order(date: :asc)
  end
end
