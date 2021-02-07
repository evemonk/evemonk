# frozen_string_literal: true

class CreateEveCertificateRecommendedTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :eve_certificate_recommended_types, id: :uuid do |t|
      t.bigint :certificate_id
      t.bigint :type_id

      t.timestamps
    end
  end
end
