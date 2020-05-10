# frozen_string_literal: true

module Eve
  class LoyaltyStoreOffer < ApplicationRecord
    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    belongs_to :type,
      primary_key: "type_id",
      optional: true
  end
end
