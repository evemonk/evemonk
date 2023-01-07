# frozen_string_literal: true

require "rails_helper"

describe Eve::Agent do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Locationable) }

  it { should be_a(Imageable) }

  it { expect(described_class.table_name).to eq("eve_agents") }

  it { should respond_to(:versions) }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:division).optional(true) }

  # TODO: later
  # it { should have_many(:standings) }

  describe "#icon_tiny" do
    before { expect(subject).to receive(:character_portrait_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:character_portrait_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#icon_medium" do
    before { expect(subject).to receive(:character_portrait_url).with(128) }

    specify { expect { subject.icon_medium }.not_to raise_error }
  end

  describe "#icon_large" do
    before { expect(subject).to receive(:character_portrait_url).with(256) }

    specify { expect { subject.icon_large }.not_to raise_error }
  end

  describe "#icon_huge" do
    before { expect(subject).to receive(:character_portrait_url).with(512) }

    specify { expect { subject.icon_huge }.not_to raise_error }
  end

  describe "#icon_gigantic" do
    before { expect(subject).to receive(:character_portrait_url).with(1024) }

    specify { expect { subject.icon_gigantic }.not_to raise_error }
  end

  # private methods

  describe "#character_portrait_url" do
    subject { build(:eve_agent, id: 3_010_637) }

    before do
      #
      # imageable_url("characters", id, "portrait", size)
      #
      expect(subject).to receive(:imageable_url).with("characters", 3_010_637, "portrait", 1024)
    end

    specify { expect { subject.send(:character_portrait_url, 1024) }.not_to raise_error }
  end
end
