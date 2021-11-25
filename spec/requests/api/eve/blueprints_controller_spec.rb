# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::BlueprintsController do
  before { Setting.use_image_proxy = true }

  describe "#index" do
    it "without param q" do
      get "/api/eve/blueprints"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 0,
        "total_pages" => 0,
        "current_page" => 1,
        "blueprints" => [])
    end

    it "with param q" do
      create(:eve_type,
        type_id: 24_699,
        name: "Drake Blueprint",
        published: true,
        is_blueprint: true)

      get "/api/eve/blueprints", params: { q: "drake" }

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 1,
        "total_pages" => 1,
        "current_page" => 1,
        "blueprints" => [{
          "id" => 24_699,
          "name" => "Drake Blueprint",
          "icon" => "https://imageproxy.evemonk.com/https://images.evetech.net/types/24699/bp?size=32"
        }])
    end
  end
end
