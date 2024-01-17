# app/serializers/munchie_attributes_serializer.rb
class MunchieSerializer
  def initialize(munchie_data)
    @data = munchie_data
  end

  def to_json
    {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: @data.destination_city,
          forecast: {
            summary: @data.forecast[:summary],
            temperature: @data.forecast[:temperature]
          },
          restaurant: {
            name: @data.name,
            address: @data.address,
            rating: @data.rating,
            reviews: @data.reviews
          }
        }
      }
    }
  end
end
