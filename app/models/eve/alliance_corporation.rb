# frozen_string_literal: true

module Eve
  class AllianceCorporation < ApplicationRecord
    # TODO: has_paper_trail

    belongs_to :alliance,
               primary_key: :alliance_id,
               counter_cache: :corporations_count,
               optional: true

    belongs_to :corporation, primary_key: :corporation_id, optional: true
  end
end
