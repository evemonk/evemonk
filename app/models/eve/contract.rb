# frozen_string_literal: true

module Eve
  class Contract < ApplicationRecord
    # TODO: finish migration
    belongs_to :region,
      primary_key: "region_id",
      optional: true

    # TODO: finish migration
    belongs_to :issuer,
      class_name: "Eve::Character",
      primary_key: "character_id",
      optional: true

    # TODO: finish migration
    belongs_to :issuer_corporation,
      class_name: "Eve::Corporation",
      primary_key: "corporation_id",
      optional: true
  end
end
