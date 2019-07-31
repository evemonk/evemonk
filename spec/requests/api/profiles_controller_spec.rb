# frozen_string_literal: true

require "rails_helper"

describe Api::ProfilesController do
  describe "#show" do
    it "returns info about user" do
      user = create(:user,
                    email: "me@example.com",
                    created_at: "2010-01-15T15:26:00Z",
                    updated_at: "2010-01-16T15:26:00Z")

      session = create(:session, user: user)

      create(:character, user: user, character_id: "123", name: "Character name")

      get "/api/profile", headers: {'Authorization': "Bearer #{session.token}"}

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).keys.sort).to eq(["characters_count", "created_at", "email", "updated_at"])

      expect(JSON.parse(response.body)["characters_count"]).to eq(1)

      expect(JSON.parse(response.body)["created_at"]).to eq("2010-01-15T15:26:00Z")

      expect(JSON.parse(response.body)["email"]).to eq("me@example.com")

      expect(JSON.parse(response.body)["updated_at"]).to eq("2010-01-16T15:26:00Z")
    end
  end
end
