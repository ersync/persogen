Dir[Rails.root.join('lib', 'core_extensions', '*.rb')].each { |f| require f }

Devise::Controllers::SignInOut.prepend CoreExtensions::SignInOut