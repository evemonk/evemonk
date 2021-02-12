# frozen_string_literal: true

module Eve
  class CertificateSkill < ApplicationRecord
    belongs_to :certificate

    belongs_to :type,
      foreign_key: "skill_id",
      primary_key: "type_id",
      optional: true
  end
end
