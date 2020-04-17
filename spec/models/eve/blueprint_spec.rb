# frozen_string_literal: true

require "rails_helper"

describe Eve::Blueprint do
  it { should be_a(Eve::Type) }

  describe "default_scope" do
    let!(:eve_type1) { create(:eve_type, is_blueprint: false) }

    let!(:eve_type2) { create(:eve_type, is_blueprint: true) }

    specify { expect(described_class.count).to eq(1) }
  end

  it { should have_many(:blueprint_invention_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_skills).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_skills).with_primary_key("type_id").dependent(:destroy) }
end
