# frozen_string_literal: true

class EveCertificateSkillsCertificateId < ActiveRecord::Migration[6.1]
  def change
    add_index :eve_certificate_skills, :certificate_id
  end
end
