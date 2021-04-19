# frozen_string_literal: true

class EveCertificateRecommendedTypesCertificateId < ActiveRecord::Migration[6.1]
  def change
    add_index :eve_certificate_recommended_types, :certificate_id
  end
end
