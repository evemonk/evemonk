# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CertificateRecommendedType, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificate_recommended_types") }

  it { expect(subject).to belong_to(:certificate) }

  it { expect(subject).to belong_to(:type).optional(true) }
end
