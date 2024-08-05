class Api::V1::PeopleController < ApplicationController
  def show
    person = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      address: {
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
        zip_code: Faker::Address.zip_code
      },
      phone: Faker::PhoneNumber.phone_number,
      job: Faker::Job.title,
      company: {
        name: Faker::Company.name,
        industry: Faker::Company.industry
      },
      social_media: {
        twitter: Faker::Internet.username(specifier: 'twitter'),
        linkedin: Faker::Internet.username(specifier: 'linkedin')
      },
      date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      credit_card: {
        number: Faker::Finance.credit_card,
        expiry_date: Faker::Business.credit_card_expiry_date
      }
    }
    render json: { data: person }, status: :ok
  end
end
