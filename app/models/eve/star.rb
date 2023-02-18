# frozen_string_literal: true

module Eve
  class Star < ApplicationRecord
    has_paper_trail

    belongs_to :solar_system, class_name: "Eve::System", optional: true

    belongs_to :type, optional: true
  end
end
