require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/user/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/user/update"
      expect(response).to have_http_status(:success)
    end
  end

end
