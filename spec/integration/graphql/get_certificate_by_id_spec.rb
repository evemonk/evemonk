# frozen_string_literal: true

require "rails_helper"

describe "Get Certificates by ID" do
  let!(:eve_group) do
    create(:eve_group,
      group_id: 255)
  end

  let!(:eve_certificate) do
    create(:eve_certificate,
      id: 50,
      name: "Small Energy Turret",
      description: "Some description",
      group: eve_group)
  end

  let(:query) do
    %(
      query getCertificateByID {
        certificate(id: 50) {
          id
          name
          description
          groupId
          group {
            id
          }
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "certificate" => {
        "id" => "50",
        "name" => "Small Energy Turret",
        "description" => "Some description",
        "groupId" => 255,
        "group" => {
          "id" => "255"
        }
      }
    })
  end
end
