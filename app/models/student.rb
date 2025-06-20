class Student < ApplicationRecord
  has_many :enrollments
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    full_name
  end
end
