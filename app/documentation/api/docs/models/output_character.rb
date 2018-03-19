# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputCharacter
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCharacter do
          key :required, [:id, :uid, :name, :created_at, :updated_at]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'Character ID'
          end
          property :uid do
            key :type, :integer
            key :format, :int64
            key :description, 'Character UID'
          end
          property :name do
            key :type, :string
            key :description, 'Character name'
          end
          property :description do
            key :type, :string
            key :description, 'Character description'
          end
          property :gender do
            key :type, :string
            key :description, 'Character gender'
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
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Created at in ISO8601 format'
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Updated at in ISO8601 format'
          end
          key :example, id: 123,
                        uid: 1_337_512_245,
                        name: 'Johnn Dillinger',
                        description: 'some description',
                        gender: 'male',
                        race: {
                          description: 'Once a thriving tribal civilization, the Minmatar...',
                          race_id: 2,
                          name: 'Minmatar',
                          alliance_id: 500_002
                        },
                        bloodline: {
                          bloodline_id: 4,
                          name: 'Brutor',
                          description: 'A martial, strong-willed people, the Brutor...',
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
                          name: 'Minmatar Republic',
                          description: 'The Minmatar Republic was formed over a century ago when the Minmatar threw...',
                          solar_system_id: 30_002_544,
                          corporation_id: 1_000_051,
                          militia_corporation_id: 1_000_182,
                          size_factor: 5.0,
                          station_count: 570,
                          station_system_count: 291,
                          is_unique: true
                        },
                        created_at: '2016-12-12T18:35:59Z',
                        updated_at: '2016-12-12T18:36:10Z'
        end
        # :nocov:
      end
    end
  end
end
