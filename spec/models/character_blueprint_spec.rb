# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprint do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should be_a(ImageProxy) }

  it { expect(described_class::RELIC_CATEGORY_ID).to eq(34) }

  it { should belong_to(:character) }

  it { should belong_to(:blueprint).class_name("Eve::Blueprint").with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  describe "#bpo?" do
    context "when blueprint is original" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.bpo?).to eq(true) }
    end

    context "when blueprint is copy" do
      subject { build(:character_blueprint, quantity: -2) }

      specify { expect(subject.bpo?).to eq(false) }
    end
  end

  describe "#bpc?" do
    context "when blueprint is original" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.bpc?).to eq(false) }
    end

    context "when blueprint is copy" do
      subject { build(:character_blueprint, quantity: -2) }

      specify { expect(subject.bpc?).to eq(true) }
    end
  end

  describe "#stacked?" do
    context "when stacked" do
      subject { build(:character_blueprint, quantity: 10) }

      specify { expect(subject.stacked?).to eq(true) }
    end

    context "when not stacked" do
      subject { build(:character_blueprint, quantity: -1) }

      specify { expect(subject.stacked?).to eq(false) }
    end
  end

  describe "#relic?" do
    context "when relic" do
      let!(:eve_group) do
        create(:eve_group,
          group_id: 111,
          category_id: described_class::RELIC_CATEGORY_ID)
      end

      let!(:eve_type) do
        create(:eve_type,
          type_id: 123,
          group_id: 111,
          is_blueprint: true)
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          type_id: 123)
      end

      subject { character_blueprint.reload }

      specify { expect(subject.relic?).to eq(true) }
    end

    context "when not relic" do
      let!(:eve_group) do
        create(:eve_group,
          group_id: 222,
          category_id: 999)
      end

      let!(:eve_type) do
        create(:eve_type,
          type_id: 234,
          group_id: 222,
          is_blueprint: true)
      end

      let!(:character_blueprint) do
        create(:character_blueprint,
          type_id: 234)
      end

      subject { character_blueprint.reload }

      specify { expect(subject.relic?).to eq(false) }
    end
  end

  describe "#material_efficiency_formatted" do
    context "when stacked" do
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      specify { expect(subject.material_efficiency_formatted).to eq(nil) }
    end

    context "when material efficiency is zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 0)
      end

      specify { expect(subject.material_efficiency_formatted).to eq("0 %") }
    end

    context "when material efficiency is more than zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 10)
      end

      specify { expect(subject.material_efficiency_formatted).to eq("+10 %") }
    end
  end

  describe "#time_efficiency_formatted" do
    context "when stacked" do
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      specify { expect(subject.time_efficiency_formatted).to eq(nil) }
    end

    context "when time efficiency is zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 0)
      end

      specify { expect(subject.time_efficiency_formatted).to eq("0 %") }
    end

    context "when time efficiency is more than zero" do
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 10)
      end

      specify { expect(subject.time_efficiency_formatted).to eq("+10 %") }
    end
  end

  describe "#icon_tiny" do
    context "when stacked" do
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

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
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804)
      end

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
      subject do
        build(:character_blueprint,
          quantity: -2,
          type_id: 804)
      end

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
      subject do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

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
      subject do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804)
      end

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
      subject do
        build(:character_blueprint,
          quantity: -2,
          type_id: 804)
      end

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
