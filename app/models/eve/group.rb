# frozen_string_literal: true

module Eve
  class Group < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name
  end
end
