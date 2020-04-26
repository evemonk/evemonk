# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::BlueprintsController do
  before { Setting.use_image_proxy = true }

  describe "#index" do
    it "returns list of blueprints" do
      create(:eve_type,
        type_id: 24_699,
        name: "Drake Blueprint",
        published: true,
        is_blueprint: true)

      get "/api/eve/blueprints"

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
