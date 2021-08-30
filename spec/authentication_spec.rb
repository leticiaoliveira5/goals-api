require 'rails_helper'

describe 'Authentication', type: :request do
  let(:user) { create(:user) }
  let(:user_keys) { { user: { email: user.email, password: user.password } }.as_json }
  let(:token) { { Authorization: response.header['Authorization'] }.as_json }

  context 'Registration' do
    context 'with fields' do
      let(:new_user_keys) { { user: { email: 'test@example.com', password: '12345678' } }.as_json }

      it 'should sign up' do
        post user_registration_path(new_user_keys)

        expect(response.body).to eq '{"message":"Signed up sucessfully."}'
        expect(response.status).to eq 200
      end
    end

    context 'without fields' do
      let(:empty_user_keys) { { user: { email: '', password: '' } }.as_json }

      it 'should throw error' do
        expect { post user_registration_path(empty_user_keys) }.not_to change(User, :count)
        expect(response.body).to eq '{"message":"Something went wrong."}'
      end
    end

    context 'destroy registration' do
      it 'should delete user' do
        post user_session_path(user_keys)

        expect { delete(user_registration_path, headers: token) }.to change(User, :count).by(-1)
        expect(response.status).to eq 200
      end
    end
  end

  context 'Session' do
    context 'accessing an authenticated controller' do
      it 'should fail when not logged in' do
        get member_data_path

        expect(response.body).to eq 'You need to sign in or sign up before continuing.'
      end

      it 'should be successful when logged in' do
        post user_session_path(user_keys)

        get(member_data_path, headers: token)

        expect(response.body).to eq '{"message":"If you see this, you are in!"}'
        expect(response.status).to eq 200
      end
    end

    context 'log in' do
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

    context 'log out' do
      it 'should be successful with session token' do
        post user_session_path(user_keys)

        delete(destroy_user_session_path, headers: token)

        expect(response.body).to eq '{"message":"You are logged out."}'
        expect(response.status).to eq 200
      end

      it 'should fail without session token' do
        post user_session_path(user_keys)

        delete(destroy_user_session_path, headers: {})

        expect(response.body).to eq '{"message":"Hmm nothing happened."}'
        expect(response.status).to eq 401
      end
    end
  end
end
