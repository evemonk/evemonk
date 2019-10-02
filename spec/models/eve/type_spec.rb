# frozen_string_literal: true

require "rails_helper"

describe Eve::Type do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class).to respond_to(:search) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["description"]) }

  it { expect(described_class.table_name).to eq("eve_types") }

  it { should have_many(:type_dogma_attributes).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  it { should have_many(:type_dogma_effects).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  describe "#search_data" do
    let!(:type) { create(:eve_type, name: "Ragnarok") }

    specify do
      expect(type.search_data).to eq(name: "Ragnarok")
    end
  end
end
