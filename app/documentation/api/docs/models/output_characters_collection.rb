# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputCharactersCollection
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCharactersCollection do
          key :required, [:collection, :total_pages, :current_page,
                          :total_entries]
          property :collection do
            key :type, :array
            items do
              key :'$ref', :OutputCharacter
            end
          end
          property :total_pages do
            key :type, :integer
            key :format, :int64
            key :description, 'Total pages count'
          end
          property :current_page do
            key :type, :integer
            key :format, :int64
            key :description, 'Current page number'
          end
          property :total_entries do
            key :type, :integer
            key :format, :int64
            key :description, 'Total entries'
          end
          key :example,
              collection: [{ id: 123,
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
                             security_status: 1.869488166134545,
                             wallet: 409488252.49,
                             charisma: 20,
                             intelligence: 24,
                             memory: 24,
                             perception: 23,
                             willpower: 23,
                             bonus_remaps: 2,
                             created_at: '2016-12-12T18:35:59Z',
                             updated_at: '2016-12-12T18:36:10Z' }],
              total_pages: 4,
              current_page: 1,
              total_entries: 90
        end
        # :nocov:
      end
    end
  end
end
