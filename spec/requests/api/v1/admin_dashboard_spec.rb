require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      # Current Trimester: Spring 2025
      current_trimester = Trimester.create!(
        term: 'Spring',
        year: '2025',
        start_date: Date.today - 1.day,
        end_date: Date.today + 1.month,
        application_deadline: Date.today - 2.weeks
      )

      ['Ruby on Rails', 'Intro to Programming', 'Node.js', 'Python', 'React'].each do |title|
        klass = CodingClass.create!(title: "#{title} (Spring)")
        Course.create!(trimester: current_trimester, coding_class: klass)
      end

      # Upcoming Trimester: Summer 2025
      upcoming_trimester = Trimester.create!(
        term: 'Summer',
        year: '2025',
        start_date: Date.today + 2.months,
        end_date: Date.today + 3.months,
        application_deadline: Date.today + 1.month
      )

      ['Intro to Programming', 'Node.js', 'React'].each do |title|
        klass = CodingClass.create!(title: "#{title} (Summer)")
        Course.create!(trimester: upcoming_trimester, coding_class: klass)
      end

      # Past Trimester (ignored in test): Fall 2023
      Trimester.create!(
        term: 'Fall',
        year: '2023',
        start_date: Date.new(2023, 9, 1),
        end_date: Date.new(2023, 11, 30),
        application_deadline: Date.new(2023, 8, 1)
      )
    end

    it 'returns a 200 OK status' do
      get '/dashboard'
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get '/dashboard'
      expect(response.body).to include('Spring - 2025')
    end

    it 'displays links to the courses in the current trimester' do
      get '/dashboard'
      expect(response.body).to include('Ruby on Rails (Spring)')
      expect(response.body).to include('Intro to Programming (Spring)')
      expect(response.body).to include('Node.js (Spring)')
      expect(response.body).to include('Python (Spring)')
      expect(response.body).to include('React (Spring)')
    end

    it 'displays the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include('Summer - 2025')
    end

    it 'displays links to the courses in the upcoming trimester' do
      get '/dashboard'
      expect(response.body).to include('Intro to Programming (Summer)')
      expect(response.body).to include('Node.js (Summer)')
      expect(response.body).to include('React (Summer)')
    end
  end
end
