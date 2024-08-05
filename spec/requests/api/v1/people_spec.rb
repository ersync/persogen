# spec/requests/api/v1/people_controller_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::People', type: :request do
  let(:json_data) { response.parsed_body['data'] }

  before { get '/api/v1/person' }

  describe 'GET /api/v1/person' do
    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns JSON data' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns the expected top-level keys' do
      expected_keys = %w[name email address phone job company social_media date_of_birth credit_card]
      expect(json_data.keys).to match_array(expected_keys)
    end

    it 'returns a structured address with expected keys' do
      address_keys = %w[street city state country zip_code]
      expect(json_data['address'].keys).to match_array(address_keys)
    end

    it 'returns social media with expected keys' do
      social_media_keys = %w[twitter linkedin]
      expect(json_data['social_media'].keys).to match_array(social_media_keys)
    end

    it 'returns company with expected keys' do
      company_keys = %w[name industry]
      expect(json_data['company'].keys).to match_array(company_keys)
    end

    it 'returns credit card with expected keys' do
      credit_card_keys = %w[number expiry_date]
      expect(json_data['credit_card'].keys).to match_array(credit_card_keys)
    end

    it 'has a valid email format' do
      expect(json_data['email']).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end

    it 'has a valid date of birth' do
      expect { Date.parse(json_data['date_of_birth']) }.not_to raise_error
    end

    it 'has a valid credit card expiry date' do
      expect(json_data['credit_card']['expiry_date']).to match(/\A\d{4}-\d{2}-\d{2}\z/)
    end
  end
end
