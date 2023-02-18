# frozen_string_literal: true

require "rails_helper"

describe Types::EveIconType do
  describe "get icons" do
    let!(:eve_icon_1) do
      create(:eve_icon,
        id: 123,
        description: "Description 1",
        icon_file: "res:/ui/texture/icons/123.png",
        obsolete: nil)
    end

    let!(:eve_icon_2) do
      create(:eve_icon,
        id: 321,
        description: "Description 2",
        icon_file: "res:/ui/texture/icons/321.png",
        obsolete: false)
    end

    let(:query) do
      %(
        {
          icons(first: 2) {
            edges {
              node {
                id
                description
                iconFile
                obsolete
              }
              cursor
            }
            pageInfo {
              endCursor
              hasNextPage
              hasPreviousPage
              startCursor
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "icons" => {
          "edges" => [
            {
              "node" => {
                "id" => "123",
                "description" => "Description 1",
                "iconFile" => "res:/ui/texture/icons/123.png",
                "obsolete" => nil
              },
              "cursor" => "MQ"
            },
            {
              "node" => {
                "id" => "321",
                "description" => "Description 2",
                "iconFile" => "res:/ui/texture/icons/321.png",
                "obsolete" => false
              },
              "cursor" => "Mg"
            }
          ],
          "pageInfo" => {
            "endCursor" => "Mg",
            "hasNextPage" => false,
            "hasPreviousPage" => false,
            "startCursor" => "MQ"
          }
        }
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
