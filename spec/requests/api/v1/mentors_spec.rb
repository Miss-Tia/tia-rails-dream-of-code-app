require 'rails_helper'

RSpec.describe 'Api::V1::Mentors', type: :request do
  describe 'GET /mentors' do
    context 'mentors exist' do
      before do
        Mentor.create!(first_name: 'Sally', last_name: 'Giraffe', email: 'sally.giraffe@example.com')
        Mentor.create!(first_name: 'Salvatore', last_name: 'Jones', email: 'salvatore.jones@example.com')
      end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('Sally')
        expect(response.body).to include('Giraffe')
        expect(response.body).to include('Salvatore')
        expect(response.body).to include('Jones')
      end
    end

    context 'mentors do not exist' do
      it 'displays the page title but no list items' do
        get '/mentors'
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe 'GET /mentors/:id' do
    it 'displays the mentor details' do
      mentor = Mentor.create!(first_name: 'Joey', last_name: 'Fraatz', email: 'joey.fraatz@example.com')
      get "/mentors/#{mentor.id}"
      expect(response.body).to include('Joey')
      expect(response.body).to include('Fraatz')
      expect(response.body).to include('joey.fraatz@example.com')
    end
  end
end
