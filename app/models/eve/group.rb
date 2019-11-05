# frozen_string_literal: true

module Eve
  class Group < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    # belongs_to :category_id
  end
end
