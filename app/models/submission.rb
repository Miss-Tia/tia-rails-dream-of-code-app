class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :student
  belongs_to :mentor
  belongs_to :course
end
