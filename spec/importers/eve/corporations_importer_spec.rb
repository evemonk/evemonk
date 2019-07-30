# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationsImporter do
  subject(:importer) { described_class.new }

  describe "#import" do
    let(:corporation_id1) { double }

    let(:corporation_ids1) { [corporation_id1] }

    before do
      #
      # Eve::AllianceCorporation.pluck(:corporation_id).uniq # => corporation_ids1
      #
      expect(Eve::AllianceCorporation).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids1)
        end
      end
    end

    let(:corporation_id2) { double }

    let(:corporation_ids2) { [corporation_id2] }

    before do
      #
      # Eve::Character.pluck(:corporation_id).uniq # => corporation_ids2
      #
      expect(Eve::Character).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids2)
        end
      end
    end

    let(:corporation_id3) { double }

    let(:corporation_ids3) { [corporation_id3] }

    before do
      #
      # Eve::Corporation.pluck(:corporation_id).uniq # => corporation_ids3
      #
      expect(Eve::Corporation).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids3)
        end
      end
    end

    let(:corporation_id4) { double }

    let(:corporation_ids4) { [corporation_id4] }

    before do
      #
      # Eve::CharacterCorporationHistory.pluck(:corporation_id).uniq # => corporation_ids4
      #
      expect(Eve::CharacterCorporationHistory).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids4)
        end
      end
    end

    before { expect(Eve::CorporationImporterWorker).to receive(:perform_async).with(corporation_id1) }

    before { expect(Eve::CorporationImporterWorker).to receive(:perform_async).with(corporation_id2) }

    before { expect(Eve::CorporationImporterWorker).to receive(:perform_async).with(corporation_id3) }

    before { expect(Eve::CorporationImporterWorker).to receive(:perform_async).with(corporation_id4) }

    specify { expect { importer.import }.not_to raise_error }
  end
end
