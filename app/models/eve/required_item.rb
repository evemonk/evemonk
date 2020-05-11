# frozen_string_literal: true

module Eve
  class RequiredItem < ApplicationRecord
    belongs_to :loyalty_store_offer,
      primary_key: "eve_loyalty_store_offer_id"

    belongs_to :type,
      primary_key: "type_id",
      optional: true
  end
end
