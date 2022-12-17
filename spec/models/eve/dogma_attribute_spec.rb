# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttribute do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:unit).optional(true) }

  it { should belong_to(:icon).with_primary_key("icon_id").optional(true) }

  describe ".published" do
    let!(:eve_dogma_attribute_1) { create(:eve_dogma_attribute, published: false) }

    let!(:eve_dogma_attribute_2) { create(:eve_dogma_attribute, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_dogma_attribute_2]) }
  end
end
