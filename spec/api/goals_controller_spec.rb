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
      it 'should return status created and goal' do
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

  describe 'delete' do
    it 'should return success message' do
      goal = create(:goal)
      delete api_goal_path(goal)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Record deleted'
      expect(Goal.count).to eq 0
    end
  end

  describe 'edit' do
    context 'success' do
      it 'should return ok message and updated goal' do
        goal = create(:goal, title: 'Learn F')
        goal_changes = { id: goal.id, title: 'Learn French' }
        patch api_goal_path(goal_changes)

        expect(response).to have_http_status(200)
        expect(Goal.last.title).to eq 'Learn French'
      end
    end

    context 'unauthorized' do
      it 'should return status unauthorized' do
        goal = create(:goal, title: 'Learn F')
        goal_changes = { id: goal.id, title: '' }
        patch api_goal_path(goal_changes)

        expect(response).to have_http_status(401)
        expect(Goal.last.title).to eq 'Learn F'
      end
    end
  end
end
