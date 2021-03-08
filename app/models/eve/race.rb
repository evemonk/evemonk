# frozen_string_literal: true

module Eve
  class Race < Upgrow::Model
    attribute :race_id
    attribute :description_en
    attribute :description_de
    attribute :description_fr
    attribute :description_ja
    attribute :description_ru
    attribute :description_ko
    attribute :faction_id
    attribute :name_en
    attribute :name_de
    attribute :name_fr
    attribute :name_ja
    attribute :name_ru
    attribute :name_ko
  end
end
