require 'rails_helper'

describe 'Authentication', type: :request do
  let(:user) { create(:user) }

  context 'Registration' do
    context 'with fields' do
      let(:expected_response) { '{"message":"Signed up sucessfully."}' }
      let(:new_user_keys) { { user: { email: 'test@example.com', password: '12345678' } }.as_json }

      it 'should sign up' do
        post user_registration_path(new_user_keys)

        expect(response.body).to eq expected_response
      end
    end

    context 'without fields' do
      let(:expected_response) { '{"message":"Something went wrong."}' }
      let(:empty_user_keys) { { user: { email: '', password: '' } }.as_json }

      it 'should throw error' do
        post user_registration_path(empty_user_keys)

        expect(response.body).to eq expected_response
      end
    end
  end

  context 'Session' do
    context 'trying to access an authenticated controller' do
      it 'should fail when not logged in' do
        get member_data_path

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end
      it 'should be successful when logged in' do
        user_keys = { user: { email: user.email, password: user.password } }.as_json
        post user_session_path(user_keys)

        token = {Authorization: response.header["Authorization"]}.as_json
        
        get(member_data_path, headers: token)

        expect(response.body).to eq '{"message":"If you see this, you are in!"}'
        expect(response.status).to eq 200
      end
    end

    context 'log in' do
      let(:user_keys) { { user: { email: user.email, password: user.password } }.as_json }

      it 'should be successful when user has the right keys' do
        post user_session_path(user_keys)

        expect(response.body).to eq '{"message":"You are logged in."}'
        expect(response.status).to eq 200
      end

      it 'should fail when user enters wrong password or email' do
        user_wrong_password = { user: { email: 'test@example.com', password: '145678' } }.as_json
        post user_session_path(user_wrong_password)

        expect(response.body).to eq '{"error":"Invalid Email or password."}'
        expect(response.status).to eq 401
      end
    end
  end
end
