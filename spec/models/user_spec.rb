require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'secure password and validations' do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe 'generates API key' do
    it 'generates an API key before creating a user' do
      user = build(:user)
      expect(user.api_key).to be_nil

      user.save

      expect(user.api_key).to_not be_nil
      expect(user.api_key).to be_a(String)
    end
  end
end
