class User < ApplicationRecord
  has_secure_password
  validates :role, presence: true
  validates :role, inclusion: { in: %w[admin mentor student] }
end
