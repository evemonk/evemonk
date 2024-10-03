# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::DogmaAttribute do
  it { is_expected.to be_an(ApplicationRecord) }

  it { is_expected.to belong_to(:unit).optional(true) }

  it { is_expected.to belong_to(:icon).optional(true) }

  describe ".published" do
    let!(:eve_dogma_attribute_1) { create(:eve_dogma_attribute, published: false) }

    let!(:eve_dogma_attribute_2) { create(:eve_dogma_attribute, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_dogma_attribute_2]) }
  end
end
