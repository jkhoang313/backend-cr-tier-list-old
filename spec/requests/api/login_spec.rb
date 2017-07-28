require 'rails_helper'

RSpec.describe "Tier List API", :type => :request do
  include TestDataHelper

  let!(:user) { create_user }

  describe 'POST /login' do
    it 'should return the token and user when successful' do
      post("/api/login", params: {
        email: "clyde@crapp.com",
        password: "wrong password"
      })

      expect(response.status).to eq(400)
      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Incorrect email or password")
    end

    it 'should return the token and user when successful' do
      post("/api/login", params: {
        email: "clyde@crapp.com",
        password: "test"
      })

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body["user"]["id"]).to eq(user.id)
      expect(body["user"]["email"]).to eq(user.email)
      expect(body["user"]["user_name"]).to eq(user.user_name)
    end
  end
end
