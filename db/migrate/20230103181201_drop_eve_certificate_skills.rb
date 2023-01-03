# frozen_string_literal: true

class DropEveCertificateSkills < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_certificate_skills, :certificate_id

    drop_table :eve_certificate_skills, id: :uuid do |t|
      t.bigint :certificate_id
      t.bigint :skill_id
      t.integer :level
      t.integer :skill_level

      t.timestamps
    end
  end
end
