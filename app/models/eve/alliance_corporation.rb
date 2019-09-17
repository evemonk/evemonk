# frozen_string_literal: true

module Eve
  class AllianceCorporation < ApplicationRecord
    # TODO: has_paper_trail

    belongs_to :alliance,
      primary_key: :alliance_id,
      counter_cache: :corporations_count,
      optional: true

    belongs_to :corporation, primary_key: :corporation_id, optional: true

    after_commit :eve_alliance_reset_characters_count, on: [:create, :update, :destroy]

    def eve_alliance_reset_characters_count
      alliance&.reset_characters_count
    end
  end
end
