require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  describe 'POST /api/v1/students' do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    let(:invalid_attributes) do
      {
        student: {
          first_name: '', # blank
          last_name: '',  # blank
          email: 'invalidemail' # invalid format
        }
      }
    end

    it 'creates a new student with valid attributes' do
      expect do
        post '/api/v1/students', params: valid_attributes
      end.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq('validstudent@example.com')
    end

    it 'returns errors with invalid attributes' do
      expect do
        post '/api/v1/students', params: invalid_attributes
      end.not_to change(Student, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      errors = JSON.parse(response.body)['errors']
      expect(errors).to include("First name can't be blank")
      expect(errors).to include("Last name can't be blank")
      expect(errors).to include('Email is invalid')
    end
  end
end
