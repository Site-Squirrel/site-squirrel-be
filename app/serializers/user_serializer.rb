class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :phone, :role

  attributes :trips do |object|
    TripSerializer.new(object.trips)
  end
end
