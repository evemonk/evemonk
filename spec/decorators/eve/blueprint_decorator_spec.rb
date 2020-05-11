# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_an(Eve::TypeDecorator) }

  describe "#copying_time_formatted" do
    let(:eve_blueprint) do
      Eve::Blueprint.new(attributes_for(:eve_type,
        copying_time: 240,
        is_blueprint: true))
    end

    subject { eve_blueprint.decorate }

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
    let(:eve_blueprint) do
      Eve::Blueprint.new(attributes_for(:eve_type,
        type_id: 24_699,
        copying_time: 240,
        is_blueprint: true))
    end

    subject { eve_blueprint.decorate }

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
    let(:eve_blueprint) do
      Eve::Blueprint.new(attributes_for(:eve_type,
        type_id: 24_699,
        copying_time: 240,
        is_blueprint: true))
    end

    subject { eve_blueprint.decorate }

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
