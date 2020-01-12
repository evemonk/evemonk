# frozen_string_literal: true

module Eve
  class System < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    # TODO: belongs_to :constellation_id

    has_many :stargates, primary_key: "system_id"

    # TODO: belongs_to :star_id

    has_one :position, as: :positionable, dependent: :destroy
  end
end
