# frozen_string_literal: true

module Eve
  class System < ApplicationRecord
    # TODO: belongs_to :constellation_id

    has_many :stargates, primary_key: :system_id # rubocop:disable Rails/HasManyOrHasOneDependent

    # TODO: belongs_to :star_id
  end
end
