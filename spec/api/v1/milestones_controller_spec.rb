require 'rails_helper'

describe 'MilestonesController', type: :request do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user) }
  let(:user_keys) { { user: { email: user.email, password: user.password } }.as_json }
  let(:token) { { Authorization: response.header['Authorization'] }.as_json }

  before(:each) do
    post user_session_path(user_keys)
  end

  context 'show' do
    it 'should return milestone and all its steps if present' do
      milestone = create(:milestone, goal: goal)
      get api_v1_milestone_path(milestone), headers: token

      expect(JSON.parse(response.body)).to have_key('goal')
      expect(JSON.parse(response.body)).to have_key('milestone')
      expect(JSON.parse(response.body)).to have_key('steps')
    end
  end

  describe 'create' do
    context 'success' do
      it 'should return status created and goal' do
        valid_milestone = { title: 'Test Title', goal_id: goal.id }
        post api_v1_milestones_path(valid_milestone.as_json), headers: token

        expect(response).to have_http_status(201)
      end
    end

    context 'unauthorized' do
      it 'should return status unauthorized' do
        invalid_milestone = { title: '', goal_id: goal.id }
        post api_v1_milestones_path(invalid_milestone.as_json), headers: token

        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'delete' do
    it 'should return success message' do
      milestone = create(:milestone, goal: goal)
      delete api_v1_milestone_path(milestone.id.as_json), headers: token

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Record deleted'
      expect(Milestone.where(id: milestone.id)).to be_empty
    end
  end

  describe 'update' do
    context 'success' do
      it 'should return ok message and updated milestone' do
        milestone = create(:milestone, title: 'Learn F', goal: goal)
        milestone_changes = { title: 'Learn French' }
        patch api_v1_milestone_path(milestone.id, milestone_changes.as_json), headers: token

        expect(response).to have_http_status(200)
        expect(Milestone.last.title).to eq 'Learn French'
      end
    end

    context 'should return status 422 if milestone not updated' do
      it 'should return status unprocessable' do
        milestone = create(:milestone, title: 'Learn F', goal: goal)
        milestone_changes = { title: '' }
        patch api_v1_milestone_path(milestone.id, milestone_changes.as_json), headers: token

        expect(response).to have_http_status(422)
        expect(Milestone.last.title).to eq 'Learn F'
      end
    end
  end
end
