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

    let(:corporation_id_1) { double }

    let(:corporation_ids_1) { [corporation_id_1] }

    before do
      #
      # Eve::Character.distinct.pluck(:corporation_id) # => corporation_ids_1
      #
      expect(Eve::Character).to receive(:distinct) do
        double.tap do |a|
          expect(a).to receive(:pluck).with(:corporation_id)
            .and_return(corporation_ids_1)
        end
      end
    end

    let(:corporation_id_2) { double }

    let(:corporation_ids_2) { [corporation_id_2] }

    before do
      #
      # Eve::CharacterCorporationHistory.distinct.pluck(:corporation_id) # => corporation_ids_2
      #
      expect(Eve::CharacterCorporationHistory).to receive(:distinct) do
        double.tap do |a|
          expect(a).to receive(:pluck).with(:corporation_id)
            .and_return(corporation_ids_2)
        end
      end
    end

    let(:corporation_id_3) { double }

    let(:corporation_ids_3) { [corporation_id_3] }

    before do
      #
      # Eve::Bloodline.distinct.pluck(:corporation_id) # => corporation_ids_3
      #
      expect(Eve::Bloodline).to receive(:distinct) do
        double.tap do |a|
          expect(a).to receive(:pluck).with(:corporation_id)
            .and_return(corporation_ids_3)
        end
      end
    end

    let(:corporation_id_4) { double }

    let(:corporation_ids_4) { [corporation_id_4] }

    before do
      #
      # Eve::Alliance.where.not(creator_corporation_id: 0)
      #              .pluck(:creator_corporation_id).uniq # => corporation_ids_4
      #
      expect(Eve::Alliance).to receive(:where) do
        double.tap do |a|
          expect(a).to receive(:not).with(creator_corporation_id: 0) do
            double.tap do |b|
              expect(b).to receive(:pluck).with(:creator_corporation_id) do
                double.tap do |c|
                  expect(c).to receive(:uniq).and_return(corporation_ids_4)
                end
              end
            end
          end
        end
      end
    end

    let(:corporation_id_5) { double }

    let(:corporation_ids_5) { [corporation_id_5] }

    before do
      #
      # Eve::Alliance.pluck(:executor_corporation_id).uniq # => corporation_ids_5
      #
      expect(Eve::Alliance).to receive(:pluck).with(:executor_corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids_5)
        end
      end
    end

    let(:corporation_id_6) { double }

    let(:corporation_ids_6) { [corporation_id_6] }

    before do
      #
      # Eve::CorporationAllianceHistory.pluck(:corporation_id).uniq # => corporation_ids_6
      #
      expect(Eve::CorporationAllianceHistory).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids_6)
        end
      end
    end

    let(:corporation_id_7) { double }

    let(:corporation_ids_7) { [corporation_id_7] }

    before do
      #
      # Eve::Faction.where.not(corporation_id: nil).pluck(:corporation_id).uniq # => corporation_ids_7
      #
      expect(Eve::Faction).to receive(:where) do
        double.tap do |a|
          expect(a).to receive(:not).with(corporation_id: nil) do
            double.tap do |b|
              expect(b).to receive(:pluck).with(:corporation_id) do
                double.tap do |c|
                  expect(c).to receive(:uniq).and_return(corporation_ids_7)
                end
              end
            end
          end
        end
      end
    end

    let(:corporation_id_8) { double }

    let(:corporation_ids_8) { [corporation_id_8] }

    before do
      #
      # Eve::Faction.where.not(militia_corporation_id: nil).pluck(:militia_corporation_id).uniq # => corporation_ids_8
      #
      expect(Eve::Faction).to receive(:where) do
        double.tap do |a|
          expect(a).to receive(:not).with(militia_corporation_id: nil) do
            double.tap do |b|
              expect(b).to receive(:pluck).with(:militia_corporation_id) do
                double.tap do |c|
                  expect(c).to receive(:uniq).and_return(corporation_ids_8)
                end
              end
            end
          end
        end
      end
    end

    let(:corporation_id_9) { double }

    let(:corporation_ids_9) { [corporation_id_9] }

    before do
      #
      # Character.pluck(:corporation_id).uniq # => corporation_ids_9
      #
      expect(Character).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporation_ids_9)
        end
      end
    end

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_1) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_2) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_3) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_4) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_5) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_6) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_7) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_8) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id_9) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
