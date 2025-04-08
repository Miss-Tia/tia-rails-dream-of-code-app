class LessonTopic < ApplicationRecord
    belongs_to :lesson
    belongs_to :topic
    has_many :lesson_topics
    has_many :lessons, through: :lesson_topics
  end
