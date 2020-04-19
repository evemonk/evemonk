# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :alliance, primary_key: "alliance_id", optional: true

    has_many :bloodlines
  end
end
