# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CertificateSkill do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificate_skills") }

  it { is_expected.to belong_to(:certificate) }

  it { is_expected.to belong_to(:type).optional }
end
