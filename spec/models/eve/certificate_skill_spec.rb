# frozen_string_literal: true

require "rails_helper"

describe Eve::CertificateSkill do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificate_skills") }

  it { should belong_to(:certificate) }

  it { should belong_to(:type).with_foreign_key("skill_id").with_primary_key("type_id").optional(true) }
end
