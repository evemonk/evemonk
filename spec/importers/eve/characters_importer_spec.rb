# frozen_string_literal: true

require "rails_helper"

describe Eve::CharactersImporter do
  describe "#import" do
    let(:character_ids) { [1] }

    let(:alliance_creator_ids) { [2] }

    let(:corporation_ceo_ids) { [3] }

    let(:corporation_creator_ids) { [4] }

    before { expect(Eve::Character).to receive(:pluck).with(:character_id).and_return(character_ids) }

    before { expect(Eve::Alliance).to receive(:pluck).with(:creator_id).and_return(alliance_creator_ids) }

    before { expect(Eve::Corporation).to receive(:pluck).with(:ceo_id).and_return(corporation_ceo_ids) }

    before { expect(Eve::Corporation).to receive(:pluck).with(:creator_id).and_return(corporation_creator_ids) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(1) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(2) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(3) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(4) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
