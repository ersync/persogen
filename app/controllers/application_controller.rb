class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  Devise::Controllers::SignInOut.prepend CoreExtensions::SignInOut

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[email password password_confirmation current_password])
  end
end
