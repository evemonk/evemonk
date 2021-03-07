# frozen_string_literal: true

module Eve
  class MoonRecord < ApplicationRecord
    # has_paper_trail
    #
    # belongs_to :system,
    #   primary_key: "system_id",
    #   optional: true
    #
    # belongs_to :planet,
    #   primary_key: "planet_id",
    #   optional: true
    #
    # has_one :position,
    #   as: :positionable,
    #   dependent: :destroy
  end
end
