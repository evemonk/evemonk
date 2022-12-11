# frozen_string_literal: true

require "rails_helper"

describe Eve::CharactersCorporationHistoryImporter do
  describe "#import" do
    let(:character_ids) { [2, 1] }

    before { expect(Eve::Character).to receive(:ids).and_return(character_ids) }

    before { expect(Eve::UpdateCharacterCorporationHistoryJob).to receive(:perform_later).with(1) }

    before { expect(Eve::UpdateCharacterCorporationHistoryJob).to receive(:perform_later).with(2) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
