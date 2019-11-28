# frozen_string_literal: true

require "rails_helper"

describe CharacterAssetsImporter do
  context "when character found" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    let(:json) { double }

    let(:asset) { instance_double(EveOnline::ESI::Models::Asset, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterAssets,
        assets: [asset])
    end

    before { expect(EveOnline::ESI::CharacterAssets).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

    before do
      #
      # character.character_assets.destroy_all
      #
      expect(character).to receive(:character_assets) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before do
      #
      # character.character_assets.create!(asset.as_json)
      #
      expect(character).to receive(:character_assets) do
        double.tap do |a|
          expect(a).to receive(:create!).with(json)
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end

  context "when character not found (ActiveRecord::RecordNotFound)" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

    before do
      #
      # Rails.logger.info("Character with ID #{ character_id } not found")
      #
      expect(Rails).to receive(:logger) do
        double.tap do |a|
          expect(a).to receive(:info).with("Character with ID #{character_id} not found")
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
