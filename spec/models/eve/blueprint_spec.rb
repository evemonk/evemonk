# frozen_string_literal: true

require "rails_helper"

describe Eve::Blueprint do
  it { should be_a(Eve::Type) }

  it { should have_many(:blueprint_invention_materials).dependent(:destroy) }

  it { should have_many(:blueprint_invention_products).dependent(:destroy) }

  it { should have_many(:blueprint_invention_skills).dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_materials).dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_products).dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_skills).dependent(:destroy) }

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
    before { expect(subject).to receive(:type_bp_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:type_bp_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  # private methods

  describe "#type_bp_url" do
    subject { Eve::Blueprint.new(attributes_for(:eve_type, id: 24_699, is_blueprint: true)) }

    before do
      #
      # imageable_url("types", id, "bp", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 24_699, "bp", 32)
    end

    specify { expect { subject.send(:type_bp_url, 32) }.not_to raise_error }
  end
end
