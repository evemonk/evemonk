# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    belongs_to :faction, optional: true

    has_many :bloodlines # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :stations # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
