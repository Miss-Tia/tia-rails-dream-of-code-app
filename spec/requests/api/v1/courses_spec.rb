require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  let!(:current_trimester) do
    Trimester.create!(
      term: 'Spring',
      year: '2025',
      start_date: Date.today - 1.day,
      end_date: Date.today + 2.months,
      application_deadline: Date.today - 1.month
    )
  end

  let!(:past_trimester) do
    Trimester.create!(
      term: 'Fall',
      year: '2024',
      start_date: Date.today - 1.year,
      end_date: Date.today - 11.months,
      application_deadline: Date.today - 13.months
    )
  end

  let!(:future_trimester) do
    Trimester.create!(
      term: 'Summer',
      year: '2026',
      start_date: Date.today + 6.months,
      end_date: Date.today + 8.months,
      application_deadline: Date.today + 5.months
    )
  end

  let!(:coding_class) do
    CodingClass.create!(title: 'Ruby on Rails')
  end

  let!(:current_course) do
    Course.create!(trimester: current_trimester, coding_class: coding_class)
  end

  let!(:past_course) do
    Course.create!(trimester: past_trimester, coding_class: coding_class)
  end

  let!(:future_course) do
    Course.create!(trimester: future_trimester, coding_class: coding_class)
  end

  describe 'GET /api/v1/courses' do
    it 'returns a JSON response with the current trimester courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json['courses']).to be_an(Array)
      expect(json['courses'].size).to eq(1)
      expect(json['courses'].first['title']).to eq('Ruby on Rails')
    end
  end
end
