require 'rails_helper'

describe 'Authentication', type: :request do
  context 'Registration' do
    context 'with fields' do
      let(:expected_response) { '{"message":"Signed up sucessfully."}' }
      let(:user_keys) { { user: { email: 'test@example.com', password: '12345678' } }.as_json }

      it 'should sign up' do
        post user_registration_path(user_keys)

        expect(response.body).to eq expected_response
      end
    end

    context 'without fields' do
      let(:expected_response) { '{"message":"Something went wrong."}' }
      let(:user_keys) { { user: { email: '', password: '' } }.as_json }

      it 'should throw error' do
        post user_registration_path(user_keys)

        expect(response.body).to eq expected_response
      end
    end
  end

  context 'Authentication' do
    context 'trying to access an authenticated controller' do
      # let(:expected_response) do
      #   '<html><body>You are being <a href="http://www.example.com/users/sign_in">redirected</a>.</body></html>'
      # end
      let(:expected_response) { 'You need to sign in or sign up before continuing.' }

      it 'should fail when not logged in' do
        get member_data_path

        expect(response.body).to eq expected_response
      end
    end
  end
end
