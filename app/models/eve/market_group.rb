# frozen_string_literal: true

module Eve
  class MarketGroup < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    # has_many :types
  end
end
