require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  # Set up current, past and future trimesters and courses for each
  let!(:current_trimester) do
    Trimester.create!(
      term: 'Term',
      year: 'Year',
      start_date: Date.today - 1.month,
      end_date: Date.today + 2.months,
      application_deadline: Date.today - 1.month
    )
  end
  let!(:past_trimester) do
    Trimester.create!(
      term: 'Past Term',
      year: 'Past Year',
      start_date: Date.today - 1.year,
      end_date: Date.today - 1.year - 3.months,
      application_deadline: Date.today - 1.year
    )
  end
  let!(:future_trimester) do
    Trimester.create!(
      term: 'Future Term',
      year: 'Future Year',
      start_date: Date.today + 1.year,
      end_date: Date.today + 1.year + 3.months,
      application_deadline: Date.today + 1.month
    )
  end
  let(:coding_class) do
    CodingClass.create!(
      title: 'Intro to Javascript'
    )
  end
  let!(:past_course) do
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: past_trimester.id
    )
  end
  let!(:future_course) do
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: future_trimester.id
    )
  end
  let!(:current_course) do
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: current_trimester.id
    )
  end

  describe 'GET /api/v1/courses' do
    it 'returns only courses from the current trimester' do
      get '/api/v1/courses'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json['courses']).to be_an(Array)
      expect(json['courses'].size).to eq(1)

      course = json['courses'].first
      expect(course['id']).to eq(current_course.id)
      expect(course['title']).to eq(current_course.coding_class.title)
      expect(course['application_deadline']).to eq(current_trimester.application_deadline.to_s)
      expect(course['start_date']).to eq(current_trimester.start_date.to_s)
      expect(course['end_date']).to eq(current_trimester.end_date.to_s)
    end
  end
end
