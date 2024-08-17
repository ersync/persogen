module CoreExtensions
  module SignInOut
    def bypass_sign_in(resource, scope: nil)
      scope ||= Devise::Mapping.find_scope!(resource)
      expire_data_after_sign_in!
      warden.set_user(resource, { store: false }.merge!(scope:))
    end
  end
end
