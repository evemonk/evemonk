# frozen_string_literal: true

require "rails_helper"

describe CharacterImplantsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  # context "when character found" do
  #   let(:access_token) { double }
  #
  #   let(:character) { instance_double(Character, access_token: access_token) }
  #
  #   before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }
  #
  #   before { expect(subject).to receive(:refresh_character_access_token) }
  #
  #   before do
  #     #
  #     # character.character_implants.destroy_all
  #     #
  #     expect(character).to receive(:character_implants) do
  #       double.tap do |a|
  #         expect(a).to receive(:destroy_all)
  #       end
  #     end
  #   end
  #
  #   let(:implant_id) { double }
  #
  #   let(:esi) do
  #     instance_double(EveOnline::ESI::CharacterImplants,
  #       implant_ids: [implant_id])
  #   end
  #
  #   before { expect(EveOnline::ESI::CharacterImplants).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }
  #
  #   before do
  #     #
  #     # character.character_implants.create!(type_id: implant_id)
  #     #
  #     expect(character).to receive(:character_implants) do
  #       double.tap do |a|
  #         expect(a).to receive(:create!).with(type_id: implant_id)
  #       end
  #     end
  #   end
  #
  #   specify { expect { subject.import }.not_to raise_error }
  # end
end
