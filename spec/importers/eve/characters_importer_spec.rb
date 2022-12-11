# frozen_string_literal: true

require "rails_helper"

describe Eve::CharactersImporter do
  describe "#import" do
    let(:character_ids) { [1] }

    let(:alliance_creator_ids) { [1, 2] }

    let(:corporation_ceo_ids) { [1, 3] }

    let(:corporation_creator_ids) { [1, 4] }

    before { expect(Eve::Character).to receive(:ids).and_return(character_ids) }

    before { expect(Eve::Alliance).to receive(:pluck).with(:creator_id).and_return(alliance_creator_ids) }

    before do
      #
      # Eve::Corporation.where.not(ceo_id: 0).pluck(:ceo_id) # => corporation_ceo_ids
      #
      expect(Eve::Corporation).to receive(:where) do
        double.tap do |a|
          expect(a).to receive(:not).with(ceo_id: 0) do
            double.tap do |b|
              expect(b).to receive(:pluck).with(:ceo_id).and_return(corporation_ceo_ids)
            end
          end
        end
      end
    end

    before do
      #
      # Eve::Corporation.where.not(creator_id: 1).pluck(:creator_id) # => corporation_creator_ids
      #
      expect(Eve::Corporation).to receive(:where) do
        double.tap do |a|
          expect(a).to receive(:not).with(creator_id: 1) do
            double.tap do |b|
              expect(b).to receive(:pluck).with(:creator_id).and_return(corporation_creator_ids)
            end
          end
        end
      end
    end

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(2) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(3) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(4) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
