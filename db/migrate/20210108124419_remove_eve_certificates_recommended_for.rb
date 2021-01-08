# frozen_string_literal: true

class RemoveEveCertificatesRecommendedFor < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_certificates, :recommended_for, :bigint, array: true
  end
end
