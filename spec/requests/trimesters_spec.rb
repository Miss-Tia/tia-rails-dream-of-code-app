require 'rails_helper'

RSpec.describe 'Trimesters', type: :request do
  describe 'GET /trimesters/:id/edit' do
    it 'shows the edit form with application deadline label' do
      trimester = Trimester.create!(
        year: '2025',
        term: 'Fall',
        application_deadline: Date.today + 30,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      get edit_trimester_path(trimester)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Application deadline')
    end
  end

  describe 'PATCH /trimesters/:id' do
    it 'updates the application deadline with valid input' do
      trimester = Trimester.create!(
        year: '2025',
        term: 'Fall',
        application_deadline: Date.today + 30,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      patch trimester_path(trimester), params: {
        trimester: {
          application_deadline: Date.today + 90
        }
      }

      expect(response).to redirect_to(trimester_path(trimester))
      follow_redirect!
      expect(response.body).to include('Trimester updated successfully!')
      expect(trimester.reload.application_deadline).to eq(Date.today + 90)
    end

    it 'does not update with invalid input (missing date)' do
      trimester = Trimester.create!(
        year: '2025',
        term: 'Winter',
        application_deadline: Date.today + 45,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      patch trimester_path(trimester), params: {
        trimester: {
          application_deadline: nil
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('prohibited this trimester from being saved')
    end

    it 'returns 400 if no application deadline provided' do
      trimester = Trimester.create!(
        year: '2025',
        term: 'Spring',
        application_deadline: Date.today + 30,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      patch trimester_path(trimester), params: {
        trimester: {}
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'returns 400 if application deadline is an invalid date' do
      trimester = Trimester.create!(
        year: '2025',
        term: 'Spring',
        application_deadline: Date.today + 30,
        start_date: Date.today + 60,
        end_date: Date.today + 120
      )

      patch trimester_path(trimester), params: {
        trimester: {
          application_deadline: 'not-a-date'
        }
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'returns 404 if trimester does not exist' do
      patch '/trimesters/999999', params: {
        trimester: {
          application_deadline: Date.today + 60
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end
end
