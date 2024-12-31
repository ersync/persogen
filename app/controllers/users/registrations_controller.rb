class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    case request.method
    when 'POST'   then handle_post(resource)
    when 'DELETE' then handle_delete
    when 'PATCH' then handle_update(resource)
    else render_error(resource)
    end
  end

  def handle_post(resource)
    resource.persisted? ? render_success(resource, 'Sign up successful.') : render_error(resource)
  end

  def handle_delete
    render_json(200, 'Account deleted successfully.')
  end

  def handle_update(resource)
    if resource.update_with_password(account_update_params)
      render_success(resource, 'User updated successfully.')
    else
      render_error(resource)
    end
  end

  def render_success(resource, message)
    render_json(200, message, UserSerializer.new(resource).serializable_hash[:data][:attributes])
  end

  def render_error(resource)
    errors = resource.errors.messages.transform_values(&:uniq)
    render json: {
      status: { code: 422, message: 'Validation failed' },
      errors:
    }, status: :unprocessable_entity
  end

  def render_json(code, message, data = nil)
    response = { status: { code:, message: } }
    response[:data] = data if data
    render json: response, status: code == 200 ? :ok : :unprocessable_entity
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
