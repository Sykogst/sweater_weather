require 'rails_helper'

RSpec.describe "Create users, email, password ", type: :request do
  describe "POST api/v0/users" do
    new_users_params = {
      email: 'stran@gmail.com',
      password: 'Password123'
    }

    post 'api/v0/users', params: new_user
  end
end
