# frozen_string_literal: true

require "rails_helper"

describe CharacterAccessToken do
  class CharacterAccessTokenClass
    include CharacterAccessToken

    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end
  end

  describe "#refresh_character_access_token" do
    let(:character_id) { double }

    subject { CharacterAccessTokenClass.new(character_id) }

    before do
      #
      # Api::RefreshCharacterAccessToken.new(character_id).refresh
      #
      expect(Api::RefreshCharacterAccessToken).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:refresh)
        end
      end
    end

    specify { expect { subject.refresh_character_access_token }.not_to raise_error }
  end
end
