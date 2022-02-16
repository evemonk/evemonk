# frozen_string_literal: true

require "rails_helper"

describe Eve::Character do
  it { should be_an(ApplicationRecord) }

  it { should be_a(PgSearch::Model) }

  it { should be_a(ImageProxy) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_characters") }

  it { should belong_to(:alliance).optional(true) }

  it { should belong_to(:ancestry).with_primary_key("ancestry_id").optional(true) }

  it { should belong_to(:bloodline).with_primary_key("bloodline_id").optional(true) }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should belong_to(:race).with_primary_key("race_id").optional(true) }

  it { should have_many(:character_corporation_histories).with_primary_key("character_id").dependent(:destroy) }

  it { should have_one_attached(:portrait) }

  it { should have_db_index(:name) }

  it { expect(described_class).to respond_to(:search_by_name) }

  describe "#icon_tiny" do
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        character_id: 90_729_314)
    end

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
    subject do
      build(:eve_character,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end

  describe "#rounded_security_status" do
    subject do
      build(:eve_character,
        security_status: 1.1234)
    end

    specify { expect(subject.rounded_security_status).to eq(1.1) }
  end

  describe "#to_key" do
    context "when character_id is present" do
      subject { build(:eve_character, character_id: 90_729_314) }

      specify { expect(subject.to_key).to eq([90_729_314]) }
    end

    context "when character_id is not present" do
      subject { build(:eve_character, character_id: nil) }

      specify { expect(subject.to_key).to eq(nil) }
    end
  end

  describe "#to_param" do
    context "when character_id is present" do
      subject { build(:eve_character, character_id: 90_729_314) }

      specify { expect(subject.to_param).to eq("90729314") }
    end

    context "when character_id is not present" do
      subject { build(:eve_character, character_id: nil) }

      specify { expect(subject.to_param).to eq(nil) }
    end
  end
end
