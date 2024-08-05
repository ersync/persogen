class PersonGenerator
  def self.generate
    new.generate
  end

  def generate
    {
      name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
      email: Faker::Internet.email,
      address: generate_address,
      phone: Faker::PhoneNumber.phone_number,
      job: Faker::Job.title,
      company: generate_company,
      social_media: generate_social_media,
      date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      credit_card: generate_credit_card
    }
  end

  private

  def generate_address
    {
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      zip_code: Faker::Address.zip_code
    }
  end

  def generate_company
    {
      name: Faker::Company.name,
      industry: Faker::Company.industry
    }
  end

  def generate_social_media
    {
      twitter: Faker::Internet.username(specifier: 9),
      linkedin: Faker::Internet.username(specifier: 8)
    }
  end

  def generate_credit_card
    {
      number: Faker::Finance.credit_card,
      expiry_date: Faker::Business.credit_card_expiry_date
    }
  end
end
