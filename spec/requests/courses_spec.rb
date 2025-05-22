require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'POST /courses' do
    it 'creates a new course with valid input' do
      coding_class = CodingClass.create!(title: 'Ruby 101')
      trimester = Trimester.create!(
        term: 'Fall 2025',
        application_deadline: Date.today + 30,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      course_params = {
        course: {
          coding_class_id: coding_class.id,
          trimester_id: trimester.id,
          max_enrollment: 25
        }
      }

      expect(
        -> { post courses_path, params: course_params }
      ).to change(Course, :count).by(1)

      expect(response).to redirect_to(course_path(Course.last))
    end

    it 'does not create course with invalid input' do
      post courses_path, params: {
        course: {
          max_enrollment: nil
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('prohibited this course from being saved')
    end
  end
end
