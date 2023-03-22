# frozen_string_literal: true

require "rails_helper"

describe Eve::Certificate do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_certificates") }

  it { should belong_to(:group).optional(true) }

  it { should have_many(:certificate_recommended_types).dependent(:destroy) }

  it { should have_many(:certificate_skills).dependent(:destroy) }
end
