# frozen_string_literal: true

module Eve
  class Certificate < ApplicationRecord
    has_paper_trail

    belongs_to :group,
      primary_key: "group_id",
      optional: true
  end
end
