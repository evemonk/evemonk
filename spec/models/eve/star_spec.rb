# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Star, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("star_id") }

  it { expect(described_class.table_name).to eq("eve_stars") }

  it { expect(subject).to belong_to(:solar_system).class_name("Eve::System").optional(true) }

  it { expect(subject).to belong_to(:type).optional(true) }
end
