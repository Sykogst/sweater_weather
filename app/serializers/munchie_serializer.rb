# app/serializers/munchie_attributes_serializer.rb
class MunchieAttributesSerializer
  def initialize(munchie)
    @munchie = munchie
  end

  def to_json
    {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: @munchie.destination_city,
          forecast: {
            summary: @munchie.forecast[:summary],
            temperature: @munchie.forecast[:temperature]
          },
          restaurant: {
            name: @munchie.name,
            address: @munchie.address,
            rating: @munchie.rating,
            reviews: @munchie.reviews
          }
        }
      }
    }
  end
end
