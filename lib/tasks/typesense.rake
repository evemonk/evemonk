# frozen_string_literal: true

namespace :typesense do
  desc "Index Eve::Alliances in typesense"
  task alliances: :environment do
    # eve_alliances_schema = {
    #   name: "eve_alliances",
    #   fields: [
    #     {name: "name", type: "string"},
    #     {name: "ticker", type: "string", facet: true}
    #   ],
    #   default_sorting_field: "ticker"
    # }
    #
    # TYPESENSE_CLIENT.collections.create(eve_alliances_schema)
  end
end
