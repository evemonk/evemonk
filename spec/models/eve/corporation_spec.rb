# frozen_string_literal: true

require "rails_helper"

describe Eve::Corporation do
  let(:attributes) do
    attributes_for(:eve_corporation).merge(id: 1,
      created_at: Time.zone.now,
      updated_at: Time.zone.now)
  end

  subject { described_class.new(**attributes) }

  it { should be_a(Upgrow::Model) }

  describe "#icon_tiny" do
    subject { described_class.new(**attributes.merge(corporation_id: 1_344_654_522)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/corporations/1344654522/logo?size=32") }
    end
  end

  describe "#icon_small" do
    subject { described_class.new(**attributes.merge(corporation_id: 1_344_654_522)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/corporations/1344654522/logo?size=64") }
    end
  end

  describe "#icon_medium" do
    subject { described_class.new(**attributes.merge(corporation_id: 1_344_654_522)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/corporations/1344654522/logo?size=128") }
    end
  end

  describe "#icon_large" do
    subject { described_class.new(**attributes.merge(corporation_id: 1_344_654_522)) }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/corporations/1344654522/logo?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/corporations/1344654522/logo?size=256") }
    end
  end

  describe "#formatted_member_count" do
    context "when number is 3" do
      subject { described_class.new(**attributes.merge(member_count: 111)) }

      specify { expect(subject.formatted_member_count).to eq("111") }
    end

    context "when number is 6" do
      subject { described_class.new(**attributes.merge(member_count: 111_222)) }

      specify { expect(subject.formatted_member_count).to eq("111,222") }
    end
  end

  describe "#sanitized_description" do
    subject { described_class.new(**attributes.merge(description: "<b>Test</b>")) }

    specify { expect(subject.sanitized_description).to eq("Test") }
  end
end
