# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    belongs_to :alliance, primary_key: :alliance_id, optional: true
  end
end
