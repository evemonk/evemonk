# frozen_string_literal: true

module Eve
  class Unit < ApplicationRecord
    has_many :dogma_attributes # rubocop:disable Rails/HasManyOrHasOneDependent
  end
end
