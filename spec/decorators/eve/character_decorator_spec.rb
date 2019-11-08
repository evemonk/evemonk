# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#birthday" do
    context "when birthday is present" do
      let(:eve_character) do
        build(:eve_character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { eve_character.decorate }

      specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
    end

    context "when birthday is empty" do
      let(:eve_character) { build(:eve_character, birthday: nil) }

      subject { eve_character.decorate }

      specify { expect(subject.birthday).to eq(nil) }
    end
  end

  describe "#icon_tiny" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=32&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/characters/90729314/portrait?size=32&tenant=tranquility") }
    end
  end

  describe "#icon_small" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=64&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/characters/90729314/portrait?size=64&tenant=tranquility") }
    end
  end

  describe "#icon_medium" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=128&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/characters/90729314/portrait?size=128&tenant=tranquility") }
    end
  end

  describe "#icon_large" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=256&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/characters/90729314/portrait?size=256&tenant=tranquility") }
    end
  end

  describe "#icon_huge" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=512&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_huge).to eq("https://images.evetech.net/characters/90729314/portrait?size=512&tenant=tranquility") }
    end
  end

  describe "#icon_gigantic" do
    let(:eve_character) do
      build(:eve_character,
        character_id: 90_729_314)
    end

    subject { eve_character.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_gigantic).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/90729314/portrait?size=1024&tenant=tranquility") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_gigantic).to eq("https://images.evetech.net/characters/90729314/portrait?size=1024&tenant=tranquility") }
    end
  end

  describe "#description" do
    let(:eve_character) do
      build(:eve_character,
        description: "<b>Test</b>")
    end

    subject { eve_character.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#security_status" do
    let(:eve_character) do
      build(:eve_character,
        security_status: 1.1)
    end

    subject { eve_character.decorate }

    specify { expect(subject.security_status).to eq("1.1") }
  end
end
