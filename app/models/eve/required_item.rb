# frozen_string_literal: true

module Eve
  class RequiredItem < ApplicationRecord
    # TODO: finish migration
    belongs_to :loyalty_store_offer,
      foreign_key: "eve_loyalty_store_offer_id"

    # TODO: finish migration
    belongs_to :type,
      primary_key: "type_id",
      optional: true
  end
end
