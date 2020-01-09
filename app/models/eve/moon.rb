# frozen_string_literal: true

module Eve
  class Moon < ApplicationRecord
    has_paper_trail

    has_one :position, as: :positionable, dependent: :destroy
  end
end
