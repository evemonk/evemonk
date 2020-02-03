# frozen_string_literal: true

module Eve
  class Unit < ApplicationRecord
    has_paper_trail

    has_many :dogma_attributes, primary_key: "unit_id"
  end
end
