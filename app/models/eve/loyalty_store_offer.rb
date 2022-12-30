# frozen_string_literal: true

module Eve
  class LoyaltyStoreOffer < ApplicationRecord
    belongs_to :corporation, optional: true

    belongs_to :type, optional: true

    has_many :required_items,
      foreign_key: "eve_loyalty_store_offer_id",
      dependent: :destroy
  end
end
