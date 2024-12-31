require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        user: {
          first_name: 'John',
          last_name: 'Doe',
          email: 'new_user@example.com',
          password: 'ValidPass1!',
          password_confirmation: 'ValidPass1!'
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          email: 'invalid',
          password: 'short'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: valid_attributes, format: :json
        end.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_attributes, format: :json
        expect(JSON.parse(response.body)['status']['code']).to eq(200)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: invalid_attributes, format: :json
        end.not_to change(User, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_attributes, format: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'deletes the user' do
      expect do
        delete :destroy, format: :json
      end.to change(User, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, format: :json
      expect(JSON.parse(response.body)['status']['code']).to eq(200)
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user, password: 'ValidPass1!', password_confirmation: 'ValidPass1!') }
    let(:update_attributes) do
      {
        user: {
          first_name: 'Updated',
          last_name: 'Name',
          current_password: 'ValidPass1!'
        }
      }
    end
    let(:invalid_update_attributes) do
      {
        user: {
          email: 'invalid',
          current_password: 'ValidPass1!'
        }
      }
    end

    before do
      sign_in user
    end

    context 'with valid parameters' do
      it 'updates the user' do
        patch :update, params: update_attributes, format: :json
        user.reload
        expect(user.first_name).to eq('Updated')
      end

      it 'returns a success response' do
        patch :update, params: update_attributes, format: :json
        expect(JSON.parse(response.body)['status']['code']).to eq(200)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error response' do
        patch :update, params: invalid_update_attributes, format: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'unsupported HTTP method' do
    let(:user) { create(:user) }

    before do
      sign_in user
      allow_any_instance_of(ActionDispatch::Request).to receive(:method).and_return('TRACE') # Simulate an unsupported method
    end

    it 'returns an error response for unsupported HTTP methods' do
      patch :update, params: { user: { email: user.email } }, format: :json # Simulate a TRACE request
      expect(response.status).to eq(422)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['status']['message']).to eq('Validation failed')
      expect(parsed_response['errors']).to be_present
    end
  end
end
