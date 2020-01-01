# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationsImporter do
  describe "#import" do
    let(:imported_corporation_id) { double }

    let(:imported_corporation_ids) { [imported_corporation_id] }

    before do
      #
      # Eve::Corporation.pluck(:corporation_id) # => imported_corporation_ids
      #
      expect(Eve::Corporation).to receive(:pluck).with(:corporation_id).and_return(imported_corporation_ids)
    end

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
      # Eve::CharacterCorporationHistory.pluck(:corporation_id).uniq # => corporation_ids3
      #
      expect(Eve::CharacterCorporationHistory).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids3)
        end
      end
    end

    let(:corporation_id4) { double }

    let(:corporation_ids4) { [corporation_id4] }

    before do
      #
      # Eve::Bloodline.pluck(:corporation_id).uniq # => corporation_ids4
      #
      expect(Eve::Bloodline).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids4)
        end
      end
    end

    let(:corporation_id5) { double }

    let(:corporation_ids5) { [corporation_id5] }

    before do
      #
      # Eve::Alliance.pluck(:creator_corporation_id).uniq # => corporation_ids5
      #
      expect(Eve::Alliance).to receive(:pluck).with(:creator_corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids5)
        end
      end
    end

    let(:corporation_id6) { double }

    let(:corporation_ids6) { [corporation_id6] }

    before do
      #
      # Eve::Alliance.pluck(:executor_corporation_id).uniq # => corporation_ids6
      #
      expect(Eve::Alliance).to receive(:pluck).with(:executor_corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids6)
        end
      end
    end

    let(:corporation_id7) { double }

    let(:corporation_ids7) { [corporation_id7] }

    before do
      #
      # Eve::CorporationAllianceHistory.pluck(:corporation_id).uniq # => corporation_ids7
      #
      expect(Eve::CorporationAllianceHistory).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids7)
        end
      end
    end

    # TODO: addd this
    # corporation_ids8 = Eve::Faction.where.not(corporation_id: nil).pluck(:corporation_id).uniq
    #
    # corporation_ids9 = Eve::Faction.where.not(militia_corporation_id: nil).pluck(:militia_corporation_id).uniq

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id1) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id2) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id3) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id4) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id5) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id6) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id7) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
