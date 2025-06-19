class Student < ApplicationRecord
  has_many :enrollments
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    full_name
  end
end
