require 'rails_helper'

RSpec.describe 'Api::V1::People', type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  # end
  describe 'Get /api/v1/generate' do
    it 'returns a JSON with fake peron data' do
      get '/api/v1/generate'
      expect(response).to have_http_status(:ok)
      json_response = response.parsed_body
      expect(json_response['data']).to include(
        'name', 'email',
        'address', 'phone',
        'date_of_birth'
      )
    end
  end
end
