# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Category do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_categories") }

  it { is_expected.to have_many(:groups) }

  it { is_expected.to have_many(:types).through(:groups) }

  describe ".published" do
    let!(:eve_category_1) { create(:eve_category, published: false) }

    let!(:eve_category_2) { create(:eve_category, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_category_2]) }
  end
end
