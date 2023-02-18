# frozen_string_literal: true

require "rails_helper"

describe Types::EveGraphicType do
  describe "get graphics" do
    let!(:eve_graphic_1) do
      create(:eve_graphic,
        id: 123,
        collision_file: "collision_file1",
        graphic_file: "graphic_file1",
        icon_folder: "icon_folder1",
        sof_dna: "sof_dna1",
        sof_fation_name: "sof_fation_name1",
        sof_hull_name: "sof_hull_name1",
        sof_race_name: "sof_race_name1")
    end

    let!(:eve_graphic_2) do
      create(:eve_graphic,
        id: 321,
        collision_file: "collision_file2",
        graphic_file: "graphic_file2",
        icon_folder: "icon_folder2",
        sof_dna: "sof_dna2",
        sof_fation_name: "sof_fation_name2",
        sof_hull_name: "sof_hull_name2",
        sof_race_name: "sof_race_name2")
    end

    # let(:query) do
    #   %(
    #     {
    #       graphics(first: 2) {
    #         edges {
    #           node {
    #             id
    #             collisionFile
    #             graphicFile
    #             iconFolder
    #             sofDna
    #             sofFationName
    #             sofHullName
    #             sofRaceName
    #           }
    #           cursor
    #         }
    #         pageInfo {
    #           endCursor
    #           hasNextPage
    #           hasPreviousPage
    #           startCursor
    #         }
    #       }
    #     }
    #   )
    # end

    let(:query) do
      %(
        {
          graphics(first: 2) {
            edges {
              node {
                id
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
        "graphics" => {
          "edges" => [
            {
              "node" => {
                "id" => "123"
                # "collisionFile" => "collision_file1",
                # "graphicFile" => "graphic_file1",
                # "iconFolder" => "icon_folder1",
                # "sofDna" => "sof_dna1",
                # "sofFationName" => "sof_fation_name1",
                # "sofHullName" => "sof_hull_name1",
                # "sofRaceName" => "sof_race_name1"
              },
              "cursor" => "MQ"
            },
            {
              "node" => {
                "id" => "321"
                # "collisionFile" => "collision_file2",
                # "graphicFile" => "graphic_file2",
                # "iconFolder" => "icon_folder2",
                # "sofDna" => "sof_dna2",
                # "sofFationName" => "sof_fation_name2",
                # "sofHullName" => "sof_hull_name2",
                # "sofRaceName" => "sof_race_name2"
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

  describe "get graphic by id" do
    let!(:eve_graphic) do
      create(:eve_graphic,
        graphic_id: 123,
        collision_file: "collision_file1",
        graphic_file: "graphic_file1",
        icon_folder: "icon_folder1",
        sof_dna: "sof_dna1",
        sof_fation_name: "sof_fation_name1",
        sof_hull_name: "sof_hull_name1",
        sof_race_name: "sof_race_name1")
    end

    # let(:query) do
    #   %(
    #     {
    #       graphic(id: 123) {
    #         id
    #         collisionFile
    #         graphicFile
    #         iconFolder
    #         sofDna
    #         sofFationName
    #         sofHullName
    #         sofRaceName
    #       }
    #     }
    #   )
    # end

    let(:query) do
      %(
        {
          graphic(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "graphic" => {
          "id" => "123"
          # "collisionFile" => "collision_file1",
          # "graphicFile" => "graphic_file1",
          # "iconFolder" => "icon_folder1",
          # "sofDna" => "sof_dna1",
          # "sofFationName" => "sof_fation_name1",
          # "sofHullName" => "sof_hull_name1",
          # "sofRaceName" => "sof_race_name1"
        }
      })
    end
  end
end
