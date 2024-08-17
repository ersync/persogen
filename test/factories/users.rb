FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'user@example.com' }
    password { 'Password123!' }
    password_confirmation { 'Password123!' }
  end
end
