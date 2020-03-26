# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }

  describe "#bpo?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(true) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(false) }
    end
  end

  describe "#bpc?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(false) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(true) }
    end
  end

  describe "#stacked?" do
    context "when stacked" do
      let(:character_blueprint) { build(:character_blueprint, quantity: 10) }

      subject { character_blueprint.decorate }

      specify { expect(subject.stacked?).to eq(true) }
    end

    context "when not stacked" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.stacked?).to eq(false) }
    end
  end

  describe "#icon_tiny" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bp?size=32") }
      end
    end

    context "when blueprint is original" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bp?size=32") }
      end
    end

    context "when blueprint is copy" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -2,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bpc?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bpc?size=32") }
      end
    end
  end

  # def icon_small
  #   if stacked? || bpo?
  #     "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=64"
  #   elsif bpc?
  #     "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=64"
  #   end
  # end
  #
  # def material_efficiency_formatted
  #   return if stacked?
  #
  #   if material_efficiency.zero?
  #     "#{material_efficiency} %"
  #   else
  #     "+#{material_efficiency} %"
  #   end
  # end
  #
  # def time_efficiency_formatted
  #   return if stacked?
  #
  #   if time_efficiency.zero?
  #     "#{time_efficiency} %"
  #   else
  #     "+#{time_efficiency} %"
  #   end
  # end
end
