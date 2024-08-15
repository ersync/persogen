class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if request.post? && resource.persisted?
      render_successful_signup(resource)
    elsif request.post?
      render_failed_signup(resource)
    elsif request.delete?
      render_successful_deletion
    else
      render_failed_signup(resource)
    end
  end

  def render_successful_signup(resource)
    render json: {
      status: { code: 200, message: 'Sign up successful. New user created.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def render_successful_deletion
    render json: {
      status: { code: 200, message: 'Account deleted successfully.' }
    }, status: :ok
  end

  def render_failed_signup(resource)
    render json: {
      status: { code: 422, message: "Error: user couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
    }, status: :unprocessable_entity
  end
end
