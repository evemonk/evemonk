# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe "#perform" do
    let(:character_id) { double }

    before do
      #
      # Eve::CharacterImporter.new(character_id).import
      #
      expect(Eve::CharacterImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # Eve::CharacterCorporationHistoryImporter.new(character_id).import
      #
      expect(Eve::CharacterCorporationHistoryImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(character_id) }.not_to raise_error }
  end
end
