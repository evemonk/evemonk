# frozen_string_literal: true

require "rails_helper"

describe CharacterShipImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:ship_item_id) { double }

    let(:ship_name) { double }

    let(:ship_type_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterShip,
        ship_item_id: ship_item_id,
        ship_name: ship_name,
        ship_type_id: ship_type_id)
    end

    before { expect(subject).to receive(:esi).and_return(esi).exactly(3).times }

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

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterShip) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterShip) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterShip).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
