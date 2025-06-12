require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id' do
    let(:course) { Course.create!(coding_class: coding_class, trimester: trimester, max_enrollment: 25) }
    let(:coding_class) { CodingClass.create!(title: 'Ruby on Rails', description: 'Backend framework') }
    let(:trimester) do
      Trimester.create!(
        year: '2025',
        term: 'Spring',
        start_date: Date.new(2025, 3, 5),
        end_date: Date.new(2025, 6, 18),
        application_deadline: Date.new(2025, 2, 15)
      )
    end

    let!(:student) do
      Student.create!(
        first_name: 'Ada',
        last_name: 'Lovelace',
        email: 'ada@history.com'
      )
    end

    before do
      Enrollment.create!(student: student, course: course)
    end

    it 'displays the course title' do
      get course_path(course)
      expect(response.body).to include('Ruby on Rails')
    end

    it 'displays enrolled student names and emails' do
      get course_path(course)
      expect(response.body).to include('Ada Lovelace')
      expect(response.body).to include('ada@history.com')
    end
  end
end
