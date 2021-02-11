# frozen_string_literal: true

require "rails_helper"

describe Eve::CertificateSkill do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificates") }

  it { should belong_to(:certificate) }

  it { should belong_to(:type).with_primary_key("skill_id").optional(true) }
end
