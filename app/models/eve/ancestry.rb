# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    validates :ancestry_id, presence: true
  end
end
