# frozen_string_literal: true

class RecreateEveCertificateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :eve_certificate_skills do |t|
      t.references :certificate
      t.bigint :type_id
      t.integer :level
      t.integer :skill_level

      t.timestamps
    end
  end
end
