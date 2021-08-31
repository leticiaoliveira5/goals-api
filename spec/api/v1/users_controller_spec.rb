require 'rails_helper'

describe 'UsersController', type: :request do
  let(:user) { create(:user) }
  let(:user_keys) { { user: { email: user.email, password: user.password } }.as_json }
  let(:token) { { Authorization: response.header['Authorization'] }.as_json }

  context 'show' do
    let(:expected_response) { { user: user }.to_json }

    it 'should return user as json' do
      post user_session_path(user_keys)
      get api_v1_user_path(user.id), headers: token

      expect(response.body).to eq expected_response
    end
  end
end
