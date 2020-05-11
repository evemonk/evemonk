# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

  describe "#date_founded" do
    let(:eve_alliance) do
      build(:eve_alliance,
        date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00")
    end

    subject { eve_alliance.decorate }

    specify { expect(subject.date_founded).to eq("2015-05-03T19:45:17Z") }
  end

  describe "#icon_tiny" do
    let(:eve_alliance) do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    subject { eve_alliance.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/alliances/1354830081/logo?size=32") }
    end
  end

  describe "#icon_small" do
    let(:eve_alliance) do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    subject { eve_alliance.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/alliances/1354830081/logo?size=64") }
    end
  end

  describe "#icon_medium" do
    let(:eve_alliance) do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    subject { eve_alliance.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/alliances/1354830081/logo?size=128") }
    end
  end

  describe "#icon_large" do
    let(:eve_alliance) do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    subject { eve_alliance.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/alliances/1354830081/logo?size=256") }
    end
  end

  describe "#icon_huge" do
    let(:eve_alliance) do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    subject { eve_alliance.decorate }

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=512") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_huge).to eq("https://images.evetech.net/alliances/1354830081/logo?size=512") }
    end
  end

  describe "#formatted_corporations_count" do
    context "when number is 3" do
      let(:eve_alliance) do
        build(:eve_alliance,
          corporations_count: 111)
      end

      subject { eve_alliance.decorate }

      specify { expect(subject.formatted_corporations_count).to eq("111") }
    end

    context "when number is 6" do
      let(:eve_alliance) do
        build(:eve_alliance,
          corporations_count: 111_222)
      end

      subject { eve_alliance.decorate }

      specify { expect(subject.formatted_corporations_count).to eq("111 222") }
    end
  end

  describe "#formatted_characters_count" do
    context "when number is 3" do
      let(:eve_alliance) do
        build(:eve_alliance,
          characters_count: 111)
      end

      subject { eve_alliance.decorate }

      specify { expect(subject.formatted_characters_count).to eq("111") }
    end

    context "when number is 6" do
      let(:eve_alliance) do
        build(:eve_alliance,
          characters_count: 111_222)
      end

      subject { eve_alliance.decorate }

      specify { expect(subject.formatted_characters_count).to eq("111 222") }
    end
  end
end
