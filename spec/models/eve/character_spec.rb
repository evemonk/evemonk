# frozen_string_literal: true

require "rails_helper"

describe Eve::Character do
  let(:attributes) do
    attributes_for(:eve_character)
      .merge(id: 1,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)
  end

  subject { described_class.new(**attributes) }

  it { should be_a(Upgrow::Model) }

  describe "#icon_tiny" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/characters/90729314/portrait?size=32") }
    end
  end

  describe "#icon_small" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/characters/90729314/portrait?size=64") }
    end
  end

  describe "#icon_medium" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/characters/90729314/portrait?size=128") }
    end
  end

  describe "#icon_large" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/characters/90729314/portrait?size=256") }
    end
  end

  describe "#icon_huge" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=512") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_huge).to eq("https://images.evetech.net/characters/90729314/portrait?size=512") }
    end
  end

  describe "#icon_gigantic" do
    subject { described_class.new(**attributes.merge(character_id: 90_729_314)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_gigantic).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=1024") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_gigantic).to eq("https://images.evetech.net/characters/90729314/portrait?size=1024") }
    end
  end

  describe "#sanitized_description" do
    subject { described_class.new(**attributes.merge(description: "<b>Test</b>")) }

    specify { expect(subject.sanitized_description).to eq("Test") }
  end

  describe "#rounded_security_status" do
    subject { described_class.new(**attributes.merge(security_status: 1.1234)) }

    specify { expect(subject.rounded_security_status).to eq(1.1) }
  end
end
