# frozen_string_literal: true

require "rails_helper"

describe CharacterDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#birthday" do
    let(:character) do
      build(:character,
            birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.birthday).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#icon_tiny" do
    let(:character) do
      build(:character,
            character_id: 123)
    end

    subject { character.decorate }

    context "when IMAGEPROXY_ENABLED is set" do
      before { ENV["IMAGEPROXY_ENABLED"] = "yes, please" }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_32.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_tiny).to eq("https://imageserver.eveonline.com/Character/123_32.png") }
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

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_64.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_small).to eq("https://imageserver.eveonline.com/Character/123_64.png") }
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

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_128.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_medium).to eq("https://imageserver.eveonline.com/Character/123_128.png") }
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

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_256.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_large).to eq("https://imageserver.eveonline.com/Character/123_256.png") }
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

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_512.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_huge).to eq("https://imageserver.eveonline.com/Character/123_512.png") }
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

      specify { expect(subject.icon_gigantic).to eq("https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123_1024.png") }
    end

    context "when IMAGEPROXY_ENABLED is not set" do
      before { ENV["IMAGEPROXY_ENABLED"] = nil }

      specify { expect(subject.icon_gigantic).to eq("https://imageserver.eveonline.com/Character/123_1024.png") }
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
    let(:character) do
      build(:character,
            last_remap_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.last_remap_date).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#accrued_remap_cooldown_date" do
    let(:character) do
      build(:character,
            accrued_remap_cooldown_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { character.decorate }

    specify { expect(subject.accrued_remap_cooldown_date).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#wallet" do
    let(:character) do
      build(:character,
            wallet: 8252.49)
    end

    subject { character.decorate }

    specify { expect(subject.wallet).to eq("8252.49 ISK") }
  end
end
