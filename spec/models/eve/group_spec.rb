# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Group, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_groups") }

  it { expect(subject).to belong_to(:category).optional(true) }

  it { expect(subject).to have_many(:types) }

  it { expect(subject).to have_many(:certificates) }

  describe ".published" do
    let!(:eve_group_1) { create(:eve_group, published: false) }

    let!(:eve_group_2) { create(:eve_group, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_group_2]) }
  end
end
