class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :first_name, :last_name

  attribute :created_at do |user|
    user.created_at&.iso8601
  end
end
