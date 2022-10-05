# frozen_string_literal: true

require "rails_helper"

describe "Get Unit by ID" do
  let!(:eve_unit) do
    create(:eve_unit,
      id: 1,
      description: nil,
      unit_name: "Length",
      display_name: nil)
  end

  let(:query) do
    %(
       query getUnitByID {
         unit(id: 1) {
           id
           description
           unitName
           displayName
         }
       }
     )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "unit" => {
        "id" => "1",
        "description" => nil,
        "unitName" => "Length",
        "displayName" => nil
      }
    })
  end
end
