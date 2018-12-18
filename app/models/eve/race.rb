# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    has_many :characters
  end
end
