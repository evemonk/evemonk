# frozen_string_literal: true

require 'rails_helper'

describe Eve::CharacterCorporationHistoryImporter do
  describe '#import' do
    context 'when fresh data available' do
      context 'when character found' do
      end

      context 'when character not found (404)' do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        let(:eve_character) { instance_double(Eve::Character) }

        before { expect(Eve::Character).to receive(:find_by!).with(character_id: character_id).and_return(eve_character) }

        before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: character_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_character).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when character not found (ActiveRecord::RecordNotFound)' do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        before { expect(Eve::Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

        before do
          #
          # Rails.logger.info("Character with ID #{ character_id } not found")
          #
          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("Character with ID #{ character_id } not found")
            end
          end
        end

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when no fresh data available' do
    end
  end
end
