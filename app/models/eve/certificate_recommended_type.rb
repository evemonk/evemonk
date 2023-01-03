# frozen_string_literal: true

module Eve
  class CertificateRecommendedType < ApplicationRecord
    belongs_to :certificate

    belongs_to :type, optional: true
  end
end
