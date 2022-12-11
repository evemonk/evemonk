# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalCharactersImporter do
  describe "#import" do
    let(:ids) { [2, 1] }

    before do
      #
      # Eve::Character.ids # => [ids]
      #
      expect(Eve::Character).to receive(:ids).and_return(ids)
    end

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(1) }

    before { expect(Eve::UpdateCharacterJob).to receive(:perform_later).with(2) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
