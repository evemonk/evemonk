# frozen_string_literal: true

module Eve
  class Certificate < ApplicationRecord
    belongs_to :group, optional: true

    has_many :certificate_recommended_types, dependent: :destroy

    has_many :certificate_skills, dependent: :destroy
  end
end
