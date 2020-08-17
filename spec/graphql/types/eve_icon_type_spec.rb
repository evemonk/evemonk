# frozen_string_literal: true

require "rails_helper"

describe Types::EveIconType do
  describe "get icons" do
    let!(:eve_icon1) do
      create(:eve_icon,
        icon_id: 123,
        description: "Description 1",
        icon_file: "res:/ui/texture/icons/123.png",
        obsolete: nil)
    end

    let!(:eve_icon2) do
      create(:eve_icon,
        icon_id: 321,
        description: "Description 2",
        icon_file: "res:/ui/texture/icons/321.png",
        obsolete: false)
    end

    let(:query) do
      %(
        {
          icons {
            id
            description
            iconFile
            obsolete
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "icons" => [
          {
            "id" => "123",
            "description" => "Description 1",
            "iconFile" => "res:/ui/texture/icons/123.png",
            "obsolete" => nil
          },
          {
            "id" => "321",
            "description" => "Description 2",
            "iconFile" => "res:/ui/texture/icons/321.png",
            "obsolete" => false
          }
        ]
      })
    end
  end

  describe "get icon by id" do
    let!(:eve_icon) do
      create(:eve_icon,
        icon_id: 123,
        description: "Description 1",
        icon_file: "res:/ui/texture/icons/123.png",
        obsolete: nil)
    end

    let(:query) do
      %(
        {
          icon(id: 123) {
            id
            description
            iconFile
            obsolete
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "icon" => {
          "id" => "123",
          "description" => "Description 1",
          "iconFile" => "res:/ui/texture/icons/123.png",
          "obsolete" => nil
        }
      })
    end
  end
end
