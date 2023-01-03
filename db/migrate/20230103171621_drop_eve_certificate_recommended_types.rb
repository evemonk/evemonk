# frozen_string_literal: true

class DropEveCertificateRecommendedTypes < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_certificate_recommended_types, :certificate_id

    drop_table :eve_certificate_recommended_types, id: :uuid do |t|
      t.bigint :certificate_id
      t.bigint :type_id

      t.timestamps
    end
  end
end
