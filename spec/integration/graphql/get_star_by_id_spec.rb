# frozen_string_literal: true

require "rails_helper"

describe "Get Star by ID" do
  let!(:eve_star) do
    create(:eve_star,
      star_id: 123)
  end

  let(:query) do
    %(
      {
        star(id: 123) {
          id
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "star" => {
        "id" => "123"
      }
    })
  end
end
