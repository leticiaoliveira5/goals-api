require 'rails_helper'

describe 'StepsController', type: :request do
  let(:milestone) { create(:milestone) }
  let(:user_keys) { { user: { email: milestone.goal.user.email, password: milestone.goal.user.password } }.as_json }
  let(:token) { { Authorization: response.header['Authorization'] }.as_json }
  before(:each) do
    post user_session_path(user_keys)
  end

  context 'show' do
    it 'should return step' do
      step = create(:step, title: 'Have lunch', milestone_id: milestone.id)
      get api_v1_step_path(step), headers: token

      expect(response.body).to include 'Have lunch'
    end
  end

  describe 'create' do
    context 'success' do
      it 'should return status created and step' do
        valid_step = { title: 'Test Title', milestone_id: milestone.id }
        post api_v1_steps_path(valid_step.as_json), headers: token

        expect(response).to have_http_status(201)
      end
    end

    context 'unauthorized' do
      it 'should return status unauthorized' do
        invalid_step = { title: '', milestone_id: milestone.id }
        post api_v1_steps_path(invalid_step.as_json), headers: token

        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'delete' do
    it 'should return success message' do
      step = create(:step, milestone_id: milestone.id)
      delete api_v1_step_path(step.id.as_json), headers: token

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Record deleted'
      expect(Step.where(id: step.id)).to be_empty
    end
  end

  describe 'update' do
    context 'success' do
      it 'should return ok message and updated step' do
        step = create(:step, title: 'Learn F', milestone_id: milestone.id)
        step_changes = { title: 'Learn French' }
        patch api_v1_step_path(step.id, step_changes.as_json), headers: token

        expect(response).to have_http_status(200)
        expect(Step.last.title).to eq 'Learn French'
      end
    end

    context 'should return status 422 if step not updated' do
      it 'should return status unprocessable' do
        step = create(:step, title: 'Learn F', milestone_id: milestone.id)
        step_changes = { title: '' }
        patch api_v1_step_path(step.id, step_changes.as_json), headers: token

        expect(response).to have_http_status(422)
        expect(Step.last.title).to eq 'Learn F'
      end
    end
  end
end
