require 'rails_helper'

describe 'GoalsController', type: :request do
  context 'index' do
    it 'should return status ok' do
      get api_goals_path

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Hello World'
    end
  end

  describe 'create' do
    context 'success' do
      it 'should return status created' do
        valid_goal = { title: 'Test Title' }
        post api_goals_path(valid_goal.as_json)

        expect(response).to have_http_status(201)
      end
    end

    context 'unauthorized' do
      it 'should return status unauthorized' do
        invalid_goal = { title: '' }
        post api_goals_path(invalid_goal.as_json)

        expect(response).to have_http_status(401)
      end
    end
  end
end
