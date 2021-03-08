# frozen_string_literal: true

module Eve
  class RaceInput < Upgrow::Input
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

    validates :race_id, presence: true
    # validates :description, presence: true
    validates :faction_id, presence: true
    # validates :name, presence: true
  end
end
