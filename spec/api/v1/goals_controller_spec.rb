require 'rails_helper'

describe 'GoalsController', type: :request do
  let(:user) { create(:user) }
  let(:user_keys) { { user: { email: user.email, password: user.password } }.as_json }
  let(:token) { { Authorization: response.header['Authorization'] }.as_json }

  before(:each) do
    post user_session_path(user_keys)
  end

  context 'index' do
    it 'should return status ok' do
      get(api_v1_goals_path, headers: token)

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Hello World'
    end
  end

  describe 'show' do
    it 'returns goal, its milestones and steps if present' do
      goal = create(:goal, user: user)
      create(:milestone, goal: goal)
      get(api_v1_goal_path(goal.id.as_json), headers: token)

      expect(JSON.parse(response.body)).to have_key('goal')
      expect(JSON.parse(response.body)).to have_key('milestones')
      expect(JSON.parse(response.body)).to have_key('steps')
    end
  end

  describe 'create' do
    context 'success' do
      it 'should return status created and goal' do
        valid_goal = { title: 'Test Title', user_id: user.id }
        post api_v1_goals_path(valid_goal.as_json), headers: token

        expect(response).to have_http_status(201)
      end
    end

    context 'unauthorized' do
      it 'should return status unauthorized' do
        invalid_goal = { title: '', user_id: user.id }
        post api_v1_goals_path(invalid_goal.as_json), headers: token

        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'delete' do
    it 'should return success message' do
      goal = create(:goal, user: user)
      delete api_v1_goal_path(goal.id.as_json), headers: token

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Record deleted'
      expect(Goal.where(id: goal.id)).to be_empty
    end
  end

  describe 'update' do
    context 'success' do
      it 'should return ok message and updated goal' do
        goal = create(:goal, title: 'Learn F', user: user)
        goal_changes = { title: 'Learn French' }
        patch api_v1_goal_path(goal.id, goal_changes.as_json), headers: token

        expect(response).to have_http_status(200)
        expect(Goal.last.title).to eq 'Learn French'
      end
    end

    context 'unauthorized' do
      it 'should return status 422 if goal not updated' do
        goal = create(:goal, title: 'Learn F', user: user)
        goal_changes = { title: '' }
        patch api_v1_goal_path(goal.id, goal_changes.as_json), headers: token

        expect(response).to have_http_status(422)
        expect(Goal.last.title).to eq 'Learn F'
      end
    end
  end
end
