# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#birthday" do
    context "when birthday is present" do
      let(:character) do
        build(:character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { character.decorate }

      specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
    end

    context "when birthday is empty" do
      let(:character) { build(:character, birthday: nil) }

      subject { character.decorate }

      specify { expect(subject.birthday).to eq(nil) }
    end
  end

  describe "#birthday_formatted" do
    context "when birthday is present" do
      let(:character) do
        build(:character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { character.decorate }

      specify { expect(subject.birthday_formatted).to eq("2015.05.03") }
    end

    context "when birthday is empty" do
      let(:character) { build(:character, birthday: nil) }

      subject { character.decorate }

      specify { expect(subject.birthday_formatted).to eq(nil) }
    end
  end

  describe "#icon_tiny" do
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        character_id: 90_729_314)
    end

    subject { character.decorate }

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
    let(:character) do
      build(:character,
        description: "<b>Test</b>")
    end

    subject { character.decorate }

    specify { expect(subject.description).to eq("Test") }
  end

  describe "#security_status" do
    let(:character) do
      build(:character,
        security_status: 1.1)
    end

    subject { character.decorate }

    specify { expect(subject.security_status).to eq("1.1") }
  end

  describe "#last_remap_date" do
    context "when last_remap_date is present" do
      let(:character) do
        build(:character,
          last_remap_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { character.decorate }

      specify { expect(subject.last_remap_date).to eq("2015-05-03T19:45:17Z") }
    end

    context "when last_remap_date is empty" do
      let(:character) { build(:character, last_remap_date: nil) }

      subject { character.decorate }

      specify { expect(subject.last_remap_date).to eq(nil) }
    end
  end

  describe "#accrued_remap_cooldown_date" do
    context "when accrued_remap_cooldown_date is present" do
      let(:character) do
        build(:character,
          accrued_remap_cooldown_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      subject { character.decorate }

      specify { expect(subject.accrued_remap_cooldown_date).to eq("2015-05-03T19:45:17Z") }
    end

    context "when accrued_remap_cooldown_date is empty" do
      let(:character) { build(:character, accrued_remap_cooldown_date: nil) }

      subject { character.decorate }

      specify { expect(subject.accrued_remap_cooldown_date).to eq(nil) }
    end
  end

  describe "#wallet" do
    let(:character) do
      build(:character,
        wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq(8252) }
  end

  describe "#wallet_formatted" do
    let(:character) do
      build(:character,
        wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet_formatted).to eq("8,252") }
  end

  describe "#total_sp_formatted" do
    let(:character) do
      build(:character,
        total_sp: 50_362_576)
    end

    subject { character.decorate }

    specify { expect(subject.total_sp_formatted).to eq("50,362,576") }
  end

  describe "#unallocated_sp_formatted" do
    let(:character) do
      build(:character,
        unallocated_sp: 906_000)
    end

    subject { character.decorate }

    specify { expect(subject.unallocated_sp_formatted).to eq("906,000") }
  end
end
