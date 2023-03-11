# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::ManufacturingItemsController do
  describe "#index" do
    before { Setting.use_image_proxy = true }

    it "returns list of manufacturing items" do
      create(:eve_type,
        type_id: 24_698,
        name: "Drake",
        published: true,
        is_manufacturing_item: true)

      get "/api/eve/manufacturing_items", params: {q: "drake"}

      expect(response).to have_http_status(:ok)

      expect(response.parsed_body).to eq("total_count" => 1,
        "total_pages" => 1,
        "current_page" => 1,
        "items" => [{
          "id" => 24_698,
          "name" => "Drake",
          "icon" => "https://imageproxy.evemonk.com/https://images.evetech.net/types/24698/icon?size=32"
        }])
    end
  end
end
