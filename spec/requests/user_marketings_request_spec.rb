require 'rails_helper'

RSpec.describe "UserMarketings", type: :request do

  describe "GET /unsubscribe" do
    it "returns http success" do
      get "/user_marketings/unsubscribe"
      expect(response).to have_http_status(:success)
    end
  end

end
