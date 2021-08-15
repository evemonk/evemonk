# frozen_string_literal: true

require "rails_helper"

describe Eve::Blueprint do
  it { should be_a(Eve::Type) }

  describe "default_scope" do
    let!(:blueprint_1) do
      Eve::Blueprint.create!(attributes_for(:eve_type,
        is_blueprint: false))
    end

    let!(:blueprint_2) do
      Eve::Blueprint.create!(attributes_for(:eve_type,
        is_blueprint: true))
    end

    specify { expect(described_class.count).to eq(1) }

    specify { expect(described_class.all).to eq([blueprint_2]) }
  end

  it { should have_many(:blueprint_invention_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_skills).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_skills).with_primary_key("type_id").dependent(:destroy) }

  describe "#copying_time_formatted" do
    subject do
      Eve::Blueprint.new(attributes_for(:eve_type,
        copying_time: 240,
        is_blueprint: true))
    end

    before do
      #
      # HumanTime.new(copying_time).long_formatted
      #
      expect(HumanTime).to receive(:new).with(240) do
        double.tap do |a|
          expect(a).to receive(:long_formatted)
        end
      end
    end

    specify { expect { subject.copying_time_formatted }.not_to raise_error }
  end

  describe "#icon_tiny" do
    subject do
      Eve::Blueprint.new(attributes_for(:eve_type,
        type_id: 24_699,
        copying_time: 240,
        is_blueprint: true))
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/24699/bp?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/24699/bp?size=32") }
    end
  end

  describe "#icon_small" do
    subject do
      Eve::Blueprint.new(attributes_for(:eve_type,
        type_id: 24_699,
        copying_time: 240,
        is_blueprint: true))
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/24699/bp?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/24699/bp?size=64") }
    end
  end
end
