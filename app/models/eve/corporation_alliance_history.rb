# frozen_string_literal: true

module Eve
  class CorporationAllianceHistory < ApplicationRecord
    # TODO: has_paper_trail

    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    belongs_to :alliance, optional: true
  end
end
