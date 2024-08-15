class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render_json_response(
      status_code: 200,
      message: 'User logged in successfully.',
      data: serialized_user(resource)
    )
  end

  def respond_to_on_destroy
    if current_user
      render_json_response(
        status_code: 200,
        message: "User logged out successfully."
      )
    else
      render_json_response(
        status_code: 401,
        message: "Couldn't find an active session.",
        status: :unauthorized
      )
    end
  end

  def render_json_response(status_code:, message:, data: nil, status: :ok)
    response = { status: { code: status_code, message: message } }
    response[:data] = data if data
    render json: response, status: status
  end

  def serialized_user(user)
    UserSerializer.new(user).serializable_hash[:data][:attributes]
  end
end
