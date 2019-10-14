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

  describe "#icon_tiny" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_32.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_tiny).to eq("https://imageserver.eveonline.com/Character/123_32.jpg") }
    end
  end

  describe "#icon_small" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_64.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_small).to eq("https://imageserver.eveonline.com/Character/123_64.jpg") }
    end
  end

  describe "#icon_medium" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_128.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_medium).to eq("https://imageserver.eveonline.com/Character/123_128.jpg") }
    end
  end

  describe "#icon_large" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_256.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_large).to eq("https://imageserver.eveonline.com/Character/123_256.jpg") }
    end
  end

  describe "#icon_huge" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_512.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_huge).to eq("https://imageserver.eveonline.com/Character/123_512.jpg") }
    end
  end

  describe "#icon_gigantic" do
    let(:character) do
      build(:character,
        character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_gigantic).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_1024.jpg") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_gigantic).to eq("https://imageserver.eveonline.com/Character/123_1024.jpg") }
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

    specify { expect(subject.wallet_formatted).to eq("8 252") }
  end

  describe "#total_sp_formatted" do
    let(:character) do
      build(:character,
        total_sp: 50_362_576)
    end

    subject { character.decorate }

    specify { expect(subject.total_sp_formatted).to eq("50 362 576") }
  end

  describe "#unallocated_sp_formatted" do
    let(:character) do
      build(:character,
        unallocated_sp: 906_000)
    end

    subject { character.decorate }

    specify { expect(subject.unallocated_sp_formatted).to eq("906 000") }
  end
end
