# frozen_string_literal: true

module Eve
  class AllianceCorporation < ApplicationRecord
    belongs_to :alliance, primary_key: :alliance_id, optional: true

    belongs_to :corporation, primary_key: :corporation_id, optional: true
  end
end
