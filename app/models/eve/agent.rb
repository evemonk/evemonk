# frozen_string_literal: true

module Eve
  class Agent < ApplicationRecord
    include Locationable

    has_paper_trail

    belongs_to :corporation,
      primary_key: "corporation_id",
      optional: true

    # belongs_to :agent_type_id

    # belongs_to :division_id

    has_many :standings, as: :standingable
  end
end
