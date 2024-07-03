# frozen_string_literal: true

require "rails_helper"

RSpec.describe UpdateCharacterInfoService do
  describe "#execute" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    before { expect(CharacterJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterWalletJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterAttributesJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterLocationJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterShipJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterImplantsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterLoyaltyPointsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterSkillsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterSkillqueueJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterAssetsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterCorporationHistoryJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterMailLabelsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterStandingsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterWalletJournalJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterWalletTransactionsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterBlueprintsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterIndustryJobsJob).to receive(:perform_later).with(character_id) }

    before { expect(CharacterOrdersJob).to receive(:perform_later).with(character_id) }

    specify { expect { subject.execute }.not_to raise_error }
  end
end
