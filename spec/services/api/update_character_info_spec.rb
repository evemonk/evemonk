# frozen_string_literal: true

require 'rails_helper'

describe Api::UpdateCharacterInfo do
  describe '#initialize' do
    let(:character) { instance_double(Character) }

    subject { described_class.new(character) }

    its(:character) { should eq(character) }
  end

  describe '#update!' do
    let(:character) { instance_double(Character) }

    subject { described_class.new(character) }

    before { expect(subject).to receive(:character_info) }

    before { expect(subject).to receive(:character_wallet) }

    before { expect(subject).to receive(:character_attributes) }

    # before { expect(subject).to receive(:character_loyalty_points) }

    specify { expect { subject.update! }.not_to raise_error }
  end

  # private methods

  describe '#character_info' do
    let(:character_id) { double }

    let(:character) { instance_double(Character, character_id: character_id) }

    subject { described_class.new(character) }

    let(:as_json) { double }

    let(:esi) { instance_double(EveOnline::ESI::Character, as_json: as_json) }

    before { expect(EveOnline::ESI::Character).to receive(:new).with(character_id: character_id).and_return(esi) }

    before { expect(character).to receive(:update!).with(as_json) }

    specify { expect { subject.send(:character_info) }.not_to raise_error }
  end

  describe '#character_wallet' do
    let(:character_id) { double }

    let(:access_token) { double }

    let(:character) { instance_double(Character, character_id: character_id, access_token: access_token) }

    subject { described_class.new(character) }

    let(:as_json) { double }

    let(:esi) { instance_double(EveOnline::ESI::CharacterWallet, as_json: as_json) }

    before { expect(EveOnline::ESI::CharacterWallet).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

    before { expect(character).to receive(:update!).with(as_json) }

    specify { expect { subject.send(:character_wallet) }.not_to raise_error }
  end

  describe '#character_attributes' do
    let(:character_id) { double }

    let(:access_token) { double }

    let(:character) { instance_double(Character, character_id: character_id, access_token: access_token) }

    subject { described_class.new(character) }

    let(:as_json) { double }

    let(:esi) { instance_double(EveOnline::ESI::CharacterAttributes, as_json: as_json) }

    before { expect(EveOnline::ESI::CharacterAttributes).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

    before { expect(character).to receive(:update!).with(as_json) }

    specify { expect { subject.send(:character_attributes) }.not_to raise_error }
  end

  describe '#character_loyalty_points' do
    let(:character_id) { double }

    let(:access_token) { double }

    let(:character) { instance_double(Character, character_id: character_id, access_token: access_token) }

    subject { described_class.new(character) }

    specify { expect { subject.send(:character_loyalty_points) }.not_to raise_error }
  end
end
