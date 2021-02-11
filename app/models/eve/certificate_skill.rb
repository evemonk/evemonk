# frozen_string_literal: true

module Eve
  class CertificateSkill < ApplicationRecord
    belongs_to :certificate

    belongs_to :type,
      primary_key: "skill_id",
      optional: true
  end
end
