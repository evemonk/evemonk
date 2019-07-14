# frozen_string_literal: true

module Eve
  class CorporationAllianceHistory < ApplicationRecord
    belongs_to :corporation,
               primary_key: :corporation_id

    belongs_to :alliance,
               primary_key: :alliance_id,
               optional: true
  end
end
