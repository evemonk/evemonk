# frozen_string_literal: true

require "rails_helper"

describe Eve::Character do
  it { should be_an(ApplicationRecord) }

  it { should be_a(PgSearch::Model) }

  it { should be_a(Imageable) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_characters") }

  it { should belong_to(:alliance).optional(true) }

  it { should belong_to(:ancestry).optional(true) }

  it { should belong_to(:bloodline).optional(true) }

  it { should belong_to(:corporation).optional(true) }

  it { should belong_to(:faction).optional(true) }

  it { should belong_to(:race).optional(true) }

  it { should have_many(:character_corporation_histories).dependent(:destroy) }

  it { should have_one_attached(:portrait) }

  it { should have_db_index(:name) }

  it { expect(described_class).to respond_to(:search_by_name) }

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

  describe "#sanitized_description" do
    subject do
      build(:eve_character,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end

  describe "#rounded_security_status" do
    subject do
      build(:eve_character,
        security_status: 1.1234)
    end

    specify { expect(subject.rounded_security_status).to eq(1.1) }
  end

  # private methods

  describe "#character_portrait_url" do
    subject { build(:eve_character, id: 90_729_314) }

    before do
      #
      # imageable_url("characters", id, "portrait", size)
      #
      expect(subject).to receive(:imageable_url).with("characters", 90_729_314, "portrait", 1024)
    end

    specify { expect { subject.send(:character_portrait_url, 1024) }.not_to raise_error }
  end
end
