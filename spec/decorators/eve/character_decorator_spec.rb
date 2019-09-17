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
        character_id: 123)
    end

    subject { eve_character.decorate }

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
    let(:eve_character) do
      build(:eve_character,
        character_id: 123)
    end

    subject { eve_character.decorate }

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
    let(:eve_character) do
      build(:eve_character,
        character_id: 123)
    end

    subject { eve_character.decorate }

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
    let(:eve_character) do
      build(:eve_character,
        character_id: 123)
    end

    subject { eve_character.decorate }

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
    let(:eve_character) do
      build(:eve_character,
        character_id: 123)
    end

    subject { eve_character.decorate }

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
    let(:eve_character) do
      build(:eve_character,
        character_id: 123)
    end

    subject { eve_character.decorate }

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
