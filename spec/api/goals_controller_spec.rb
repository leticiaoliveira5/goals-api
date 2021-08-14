require 'rails_helper'

describe 'GoalsController', type: :request do
  context 'index' do
    it 'should return status ok' do
      get api_goals_path

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Hello World'
    end
  end
end
