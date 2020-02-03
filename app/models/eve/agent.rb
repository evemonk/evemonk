# frozen_string_literal: true

module Eve
  class Agent < ApplicationRecord
    has_paper_trail

    has_many :standings, as: :standingable
  end
end
