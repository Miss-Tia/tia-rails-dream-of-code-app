class Trimester < ApplicationRecord
  has_many :courses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  def self.current
    today = Date.today
    find_by('start_date <= ? AND end_date >= ?', today, today)
  end
end
