class Submission < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson

  validates :content, presence: true
end
