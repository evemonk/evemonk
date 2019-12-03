# frozen_string_literal: true

require "rails_helper"

describe CharacterImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  # context "when character found" do
  #   let(:character) { instance_double(Character) }
  #
  #   before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }
  #
  #   let(:json) { double }
  #
  #   let(:esi) do
  #     instance_double(EveOnline::ESI::Character,
  #       as_json: json)
  #   end
  #
  #   before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_return(esi) }
  #
  #   before { expect(character).to receive(:update!).with(json) }
  #
  #   specify { expect { subject.import }.not_to raise_error }
  # end
end
