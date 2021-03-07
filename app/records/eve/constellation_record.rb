# frozen_string_literal: true

module Eve
  class ConstellationRecord < ApplicationRecord
    # extend Mobility
    #
    # has_paper_trail
    #
    # translates :name
    #
    # belongs_to :region,
    #   primary_key: "region_id",
    #   optional: true
    #
    # has_many :systems,
    #   primary_key: "constellation_id"
    #
    # has_one :position,
    #   as: :positionable,
    #   dependent: :destroy
  end
end
