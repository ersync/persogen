FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'ValidPass1!' }
    password_confirmation { 'ValidPass1!' }
  end
end
