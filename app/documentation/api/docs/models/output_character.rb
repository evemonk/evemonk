# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputCharacter
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCharacter do
          key :required, [:id, :uid, :name, :description, :gender,
                          :security_status, :wallet, :charisma, :intelligence,
                          :memory, :perception, :willpower, :bonus_remaps,
                          :created_at, :updated_at]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, "Character ID"
          end
          property :uid do
            key :type, :integer
            key :format, :int64
            key :description, "Character UID"
          end
          property :name do
            key :type, :string
            key :description, "Character name"
          end
          property :description do
            key :type, :string
            key :description, "Character description"
          end
          property :gender do
            key :type, :string
            key :description, "Character gender"
          end
          property :race do
            key :type, :object
            key :'$ref', :OutputRace
          end
          property :bloodline do
            key :type, :object
            key :'$ref', :OutputBloodline
          end
          property :faction do
            key :type, :object
            key :'$ref', :OutputFaction
          end
          property :ancestry do
            key :type, :object
            key :'$ref', :OutputAncestry
          end
          property :alliance do
            key :type, :object
            key :'$ref', :OutputAlliance
          end
          property :corporation do
            key :type, :object
            key :'$ref', :OutputCorporation
          end
          property :security_status do
            key :type, :number
            key :format, :float
            key :description, "Character security status"
          end
          property :wallet do
            key :type, :number
            key :format, :float
            key :description, "Character wallet"
          end
          property :charisma do
            key :type, :integer
            key :format, :int64
            key :description, "Character charisma"
          end
          property :intelligence do
            key :type, :integer
            key :format, :int64
            key :description, "Character intelligence"
          end
          property :memory do
            key :type, :integer
            key :format, :int64
            key :description, "Character memory"
          end
          property :perception do
            key :type, :integer
            key :format, :int64
            key :description, "Character perception"
          end
          property :willpower do
            key :type, :integer
            key :format, :int64
            key :description, "Character willpower"
          end
          property :bonus_remaps do
            key :type, :integer
            key :format, :int64
            key :description, "Character bonus remaps"
          end
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, "Created at in ISO8601 format"
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, "Updated at in ISO8601 format"
          end
          key :example, id: 123,
                        uid: 1_337_512_245,
                        name: "Johnn Dillinger",
                        description: "some description",
                        gender: "male",
                        race: {
                          description: "Once a thriving tribal civilization, the Minmatar...",
                          race_id: 2,
                          name: "Minmatar",
                          alliance_id: 500_002
                        },
                        bloodline: {
                          bloodline_id: 4,
                          name: "Brutor",
                          description: "A martial, strong-willed people, the Brutor...",
                          race_id: 2,
                          ship_type_id: 588,
                          corporation_id: 1_000_049,
                          perception: 9,
                          willpower: 7,
                          charisma: 6,
                          memory: 4,
                          intelligence: 4
                        },
                        faction: {
                          faction_id: 500_002,
                          name: "Minmatar Republic",
                          description: "The Minmatar Republic was formed over a century ago when the Minmatar threw...",
                          solar_system_id: 30_002_544,
                          corporation_id: 1_000_051,
                          militia_corporation_id: 1_000_182,
                          size_factor: 5.0,
                          station_count: 570,
                          station_system_count: 291,
                          is_unique: true
                        },
                        ancestry: {
                          ancestry_id: 24,
                          name: "Slave Child",
                          bloodline_id: 4,
                          description: "Millions of slaves within the Amarr Empire dream of escape...",
                          short_description: "Torn from the cold and brought to the warmth of a new life.",
                          icon_id: 1664
                        },
                        alliance: {
                          alliance_id: 99_005_443,
                          name: "Kids With Guns Alliance",
                          ticker: "-KWG-",
                          creator_id: 94_195_096,
                          creator_corporation_id: 98_306_624,
                          executor_corporation_id: 98_306_624,
                          date_founded: "2015-05-03T19:45:17Z",
                          faction_id: 500_001
                        },
                        corporation: {
                          corporation_id: 98_134_807,
                          name: "MyLittleDragon",
                          ticker: "MYLID",
                          member_count: 120,
                          ceo_id: 1_208_274_826,
                          alliance_id: 99_005_443,
                          description: "",
                          tax_rate: "0.09",
                          date_founded: "2012-08-28T20:16:00Z",
                          creator_id: 265_506_411,
                          corporation_url: "http://",
                          faction_id: 500_002,
                          home_station_id: 60_004_474,
                          shares: 1000
                        },
                        security_status: 1.869488166134545,
                        wallet: 409_488_252.49,
                        charisma: 20,
                        intelligence: 24,
                        memory: 24,
                        perception: 23,
                        willpower: 23,
                        bonus_remaps: 2,
                        created_at: "2016-12-12T18:35:59Z",
                        updated_at: "2016-12-12T18:36:10Z"
        end
        # :nocov:
      end
    end
  end
end
