# frozen_string_literal: true

require "rails_helper"

describe CharacterShipImporter do
  context "when character found" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    let(:ship_item_id) { double }

    let(:ship_name) { double }

    let(:ship_type_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterShip,
        ship_item_id: ship_item_id,
        ship_name: ship_name,
        ship_type_id: ship_type_id)
    end

    before { expect(EveOnline::ESI::CharacterShip).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

    before do
      #
      # character.update!(current_ship_item_id: esi.ship_item_id,
      #                   current_ship_name: esi.ship_name,
      #                   current_ship_type_id: esi.ship_type_id)
      #
      expect(character).to receive(:update!).with(current_ship_item_id: ship_item_id,
                                                  current_ship_name: ship_name,
                                                  current_ship_type_id: ship_type_id)
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
