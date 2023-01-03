# frozen_string_literal: true

class RemoveEveCertificateCertificateId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_certificates, :certificate_id, unique: true

    remove_column :eve_certificates, :certificate_id, :bigint
  end
end
