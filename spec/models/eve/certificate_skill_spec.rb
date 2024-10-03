# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CertificateSkill do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificate_skills") }

  it { expect(subject).to belong_to(:certificate) }

  it { expect(subject).to belong_to(:type).optional(true) }
end
