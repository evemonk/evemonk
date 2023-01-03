# frozen_string_literal: true

class RecreateEveCertificateRecommendedTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :eve_certificate_recommended_types do |t|
      t.references :certificate
      t.bigint :type_id

      t.timestamps
    end
  end
end
