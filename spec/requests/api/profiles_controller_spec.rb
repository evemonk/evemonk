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

      create(:character, user: user)

      get "/api/profile", headers: {'Authorization': "Bearer #{session.token}"}

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("characters_count" => 1,
                                              "created_at" => "2010-01-15T15:26:00Z",
                                              "email" => "me@example.com",
                                              "updated_at" => "2010-01-16T15:26:00Z")
    end
  end
end
