# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalCharactersImporter do
  describe "#import" do
    let(:character_id) { double }

    before do
      #
      # Eve::Character.pluck(:character_id) => [character_id]
      #
      expect(Eve::Character).to receive(:pluck).with(:character_id).and_return([character_id])
    end

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(character_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
