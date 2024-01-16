# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer
  
  attributes  :email, 
              :api_key
end
