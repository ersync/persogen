require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  let(:password) { 'Password123!' }
  let(:user) { create(:user, password: password, password_confirmation: password) }
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'POST /login' do
    let(:valid_credentials) do
      {
        user: {
          email: user.email,
          password: password
        }
      }
    end

    it 'logs in successfully with valid credentials' do
      post '/login',
           params: valid_credentials,
           headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include(
        'status' => include(
          'code' => 200,
          'message' => 'User logged in successfully.'
        )
      )
      expect(response.headers['Authorization']).to be_present
    end
  end

  describe 'DELETE /logout' do
    context 'when user is signed in' do
      it 'logs out successfully' do
        # First login
        post '/login',
             params: { user: { email: user.email, password: password } },
             headers: headers

        token = response.headers['Authorization']

        # Then logout with the token
        delete '/logout',
               headers: headers.merge('Authorization' => token)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']['message']).to eq('User logged out successfully.')
      end
    end

    context 'when no user is signed in' do
      it 'returns unauthorized' do
        delete '/logout', headers: headers
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['status']['message']).to eq("Couldn't find an active session.")
      end
    end
  end
end
