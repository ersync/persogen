require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def fake_devise_action
      head :ok
    end
  end

  before do
    # Add a route for our fake action
    routes.draw { get 'fake_devise_action' => 'anonymous#fake_devise_action' }
    allow(controller).to receive(:devise_controller?).and_return(true)
  end

  describe '#configure_permitted_parameters' do
    it 'permits the correct parameters for account update' do
      sanitizer = double('devise_parameter_sanitizer')

      expect(sanitizer).to receive(:permit).with(
        :account_update,
        keys: %i[email password password_confirmation current_password]
      )

      allow(controller).to receive(:devise_parameter_sanitizer).and_return(sanitizer)

      get :fake_devise_action
    end
  end
end
