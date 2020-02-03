# frozen_string_literal: true

class CreateEveCertificates < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_certificates do |t|
      t.bigint :certificate_id
      t.text :description
      t.bigint :group_id
      t.string :name
      t.bigint :recommended_for, array: true

      t.timestamps
    end

    add_index :eve_certificates, :certificate_id, unique: true
  end
end
