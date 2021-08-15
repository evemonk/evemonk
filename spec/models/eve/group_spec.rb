# frozen_string_literal: true

require "rails_helper"

describe Eve::Group do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_groups") }

  it { should belong_to(:category).with_primary_key("category_id").with_foreign_key("category_id").optional(true) }

  it { should have_many(:types).with_primary_key("group_id").with_foreign_key("group_id") }

  it { should have_many(:certificates).with_primary_key("group_id").with_foreign_key("group_id") }

  describe ".published" do
    let!(:eve_group_1) { create(:eve_group, published: false) }

    let!(:eve_group_2) { create(:eve_group, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_group_2]) }
  end
end
