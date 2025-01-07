# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Certificate, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificates") }

  it { expect(subject).to belong_to(:group).optional(true) }

  it { expect(subject).to have_many(:certificate_recommended_types).dependent(:destroy) }

  it { expect(subject).to have_many(:certificate_skills).dependent(:destroy) }
end
