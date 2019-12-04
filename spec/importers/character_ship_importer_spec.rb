# frozen_string_literal: true

require "rails_helper"

describe CharacterShipImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-location.read_ship_type.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:ship_item_id) { double }

      let(:ship_name) { double }

      let(:ship_type_id) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterShip,
          ship_item_id: ship_item_id,
          ship_name: ship_name,
          ship_type_id: ship_type_id,
          scope: "esi-location.read_ship_type.v1")
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

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterShip,
          scope: "esi-location.read_ship_type.v1")
      end

      before { expect(EveOnline::ESI::CharacterShip).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:update!) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
