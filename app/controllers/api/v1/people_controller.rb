class Api::V1::PeopleController < ApplicationController
  def generate
    person = {
      name: Faker::Name.name,
      email:Faker::Internet.email,
      address:Faker::Address.full_address,
      phone:Faker::PhoneNumber.phone_number,
      date_of_birth: Faker::Date.birthday(min_age:18,max_age:65),
    }
    render json: {data: person}, status: :ok
  end
end
