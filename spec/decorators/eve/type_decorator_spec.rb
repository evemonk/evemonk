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

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/icon?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/23773/icon?size=32") }
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

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/icon?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/23773/icon?size=64") }
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

      specify { expect(subject.render_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_tiny).to eq("https://images.evetech.net/types/23773/render?size=32") }
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

      specify { expect(subject.render_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_small).to eq("https://images.evetech.net/types/23773/render?size=64") }
    end
  end

  describe "#render_medium" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.render_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_medium).to eq("https://images.evetech.net/types/23773/render?size=128") }
    end
  end

  describe "#render_large" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.render_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_large).to eq("https://images.evetech.net/types/23773/render?size=256") }
    end
  end

  describe "#render_huge" do
    let(:eve_type) do
      build(:eve_type,
        type_id: 23_773)
    end

    subject { eve_type.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.render_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/23773/render?size=512") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.render_huge).to eq("https://images.evetech.net/types/23773/render?size=512") }
    end
  end

  describe "#average_price_formatted" do
    context "when average_price is empty" do
      let(:eve_type) do
        build(:eve_type,
          average_price: nil)
      end

      subject { eve_type.decorate }

      specify { expect(subject.average_price_formatted).to eq("0") }
    end

    context "when average_price is present" do
      let(:eve_type) do
        build(:eve_type,
          average_price: 9_061_680)
      end

      subject { eve_type.decorate }

      specify { expect(subject.average_price_formatted).to eq("9 061 680") }
    end
  end
end
