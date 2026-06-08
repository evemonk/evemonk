# frozen_string_literal: true

require "rails_helper"

RSpec.describe UpdateCharactersJob do
  it { expect(subject).to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("realtime") }

  describe "#perform" do
    let!(:character_1) { create(:character, character_id: 222_333) }

    let!(:character_2) { create(:character, character_id: 333_444) }

    let!(:character_scope_1) { create(:character_scope, character: character_1, esi_token_valid: true) }

    let!(:character_scope_2) { create(:character_scope, character: character_2, esi_token_valid: false) }

    before do
      #
      # UpdateCharacterInfoService.new(scope.character.character_id).call
      #
      expect(UpdateCharacterInfoService).to receive(:new).with(222_333) do
        double.tap do |a|
          expect(a).to receive(:call)
        end
      end
    end

    before do
      #
      # UpdateCharacterInfoService.new(scope.character.character_id).call
      #
      expect(UpdateCharacterInfoService).not_to receive(:new).with(333_444)
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
