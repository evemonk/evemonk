# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

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

  describe "#icon_small" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bp?size=64") }
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

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bp?size=64") }
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

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bpc?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bpc?size=64") }
      end
    end
  end
end
