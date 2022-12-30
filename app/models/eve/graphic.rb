# frozen_string_literal: true

module Eve
  class Graphic < ApplicationRecord
    self.primary_key = "graphic_id"

    has_paper_trail
  end
end
