# frozen_string_literal: true

class CreateEveCertificateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :eve_certificate_skills, id: :uuid do |t|
      t.bigint :certificate_id
      t.bigint :skill_id
      t.integer :level

      t.timestamps
    end
  end
end
