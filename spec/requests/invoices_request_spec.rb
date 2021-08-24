require 'rails_helper'

RSpec.describe "Invoices", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/invoices/show"
      expect(response).to have_http_status(:success)
    end
  end

end
