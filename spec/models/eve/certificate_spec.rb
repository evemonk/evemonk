# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Certificate do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificates") }

  it { is_expected.to belong_to(:group).optional }

  it { is_expected.to have_many(:certificate_recommended_types).dependent(:destroy) }

  it { is_expected.to have_many(:certificate_skills).dependent(:destroy) }
end
