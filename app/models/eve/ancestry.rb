# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    belongs_to :bloodline, primary_key: :bloodline_id, optional: true

    # belongs_to :what? :icon_id?
  end
end
