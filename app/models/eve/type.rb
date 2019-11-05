# frozen_string_literal: true

module Eve
  class Type < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :description

    searchkick

    belongs_to :graphic,
      primary_key: "graphic_id",
      optional: true

    # TODO: import eve groups
    # belongs_to :group,
    #   primary_key: "group_id",
    #   optional: true

    belongs_to :icon,
      primary_key: "icon_id",
      optional: true

    # TODO: import eve market groups
    # belongs_to :market_group,
    #            primary_key: "market_group_id",
    #            optional: true

    has_many :type_dogma_attributes,
      primary_key: "type_id",
      foreign_key: "type_id",
      dependent: :destroy

    has_many :type_dogma_effects,
      primary_key: "type_id",
      foreign_key: "type_id",
      dependent: :destroy

    def search_data
      {
        name: name,
      }
    end
  end
end
