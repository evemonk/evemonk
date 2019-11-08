# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#icon_tiny" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/icon?size=32&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/23773/icon?size=32&tenant=tranquility") }
    end
  end

  describe "#icon_small" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/icon?size=64&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/23773/icon?size=64&tenant=tranquility") }
    end
  end

  describe "#render_tiny" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.render_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=32&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_tiny).to eq("https://images.evetech.net/types/23773/render?size=32&tenant=tranquility") }
    end
  end

  describe "#render_small" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.render_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=64&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_small).to eq("https://images.evetech.net/types/23773/render?size=64&tenant=tranquility") }
    end
  end
end
