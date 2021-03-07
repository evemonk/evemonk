# frozen_string_literal: true

module Eve
  class CertificateRecord < ApplicationRecord
    # has_paper_trail
    #
    # belongs_to :group,
    #   primary_key: "group_id",
    #   optional: true
    #
    # has_many :certificate_recommended_types,
    #   dependent: :destroy
    #
    # has_many :certificate_skills,
    #   dependent: :destroy
  end
end
