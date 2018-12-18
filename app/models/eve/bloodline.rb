# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    belongs_to :corporation, primary_key: :corporation_id, optional: true

    belongs_to :race, primary_key: :race_id, optional: true

    # belongs_to :eve_ship_type_id, optional: true
  end
end
