# frozen_string_literal: true

require "rails_helper"

describe Eve::Agent do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { expect(described_class.table_name).to eq("eve_agents") }

  it { should respond_to(:versions) }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should have_many(:standings) }

  describe "#icon_tiny" do
    subject do
      build(:eve_agent,
        agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/characters/3010637/portrait?size=32") }
    end
  end

  describe "#icon_small" do
    subject do
      build(:eve_agent,
        agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/characters/3010637/portrait?size=64") }
    end
  end

  describe "#icon_medium" do
    subject do
      build(:eve_agent,
        agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/characters/3010637/portrait?size=128") }
    end
  end

  describe "#icon_large" do
    let(:eve_agent) do
      build(:eve_agent,
        agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/characters/3010637/portrait?size=256") }
    end
  end

  describe "#icon_huge" do
    subject do
      build(:eve_agent,
        agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=512") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_huge).to eq("https://images.evetech.net/characters/3010637/portrait?size=512") }
    end
  end

  describe "#icon_gigantic" do
    subject do
      build(:eve_agent,
            agent_id: 3_010_637)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_gigantic).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/characters/3010637/portrait?size=1024") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_gigantic).to eq("https://images.evetech.net/characters/3010637/portrait?size=1024") }
    end
  end
end
