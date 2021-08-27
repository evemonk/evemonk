# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateCharacterPortraitJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:character_id) { double }

    before do
      #
      # Eve::CharacterPortraitImporter.new(character_id).import
      #
      expect(Eve::CharacterPortraitImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(character_id) }.not_to raise_error }
  end
end
