# frozen_string_literal: true

module Eve
  class FactionRecord < ApplicationRecord
    # include ImageProxy
    # extend Mobility
    #
    # has_paper_trail
    #
    # translates :name, :description
    #
    # belongs_to :corporation,
    #   primary_key: "corporation_id",
    #   optional: true
    #
    # belongs_to :militia_corporation,
    #   class_name: "Eve::Corporation",
    #   primary_key: "corporation_id",
    #   foreign_key: "militia_corporation_id",
    #   optional: true
    #
    # belongs_to :solar_system,
    #   class_name: "Eve::System",
    #   primary_key: "system_id",
    #   foreign_key: "solar_system_id",
    #   optional: true
    #
    # has_many :alliances, primary_key: "faction_id"
    #
    # has_many :standings, as: :standingable
    #
    # def icon_tiny
    #   "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=32"
    # end
    #
    # def icon_small
    #   "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=64"
    # end
    #
    # def icon_medium
    #   "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=128"
    # end
  end
end
