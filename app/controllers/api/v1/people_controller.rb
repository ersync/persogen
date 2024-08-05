class Api::V1::PeopleController < ApplicationController
  def index
    count = [params.fetch(:count, 10).to_i, 100].min
    people = Array.new(count) { PersonGenerator.generate }
    render json: { data: people }, status: :ok
  end

  def show
    person = PersonGenerator.generate
    render json: { data: person }, status: :ok
  end
end
