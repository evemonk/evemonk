# frozen_string_literal: true

require "rails_helper"

describe CharacterBaseImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  describe "#initialize" do
    its(:character_id) { should eq(character_id) }
  end

  describe "#import" do
    context "when everything ok" do
      before { expect(subject).to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when EveOnline::Exceptions::ResourceNotFound" do
      before { expect(subject).to receive(:update!).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("WARNING: ESI response with 404 (NOT FOUND) for Character with ID #{character_id}")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("WARNING: ESI response with 404 (NOT FOUND) for Character with ID #{character_id}")
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when ActiveRecord::RecordNotFound" do
      before { expect(subject).to receive(:update!).and_raise(ActiveRecord::RecordNotFound) }

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

  describe "#character" do
    let(:character) { instance_double(Character) }

    context "when @character is set" do
      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.character).to eq(character) }
    end

    context "when @character not set" do
      before do
        #
        # Character.lock.find_by!(character_id: character_id)
        #
        expect(Character).to receive(:lock) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: character_id)
              .and_return(character)
          end
        end
      end

      specify { expect(subject.character).to eq(character) }
    end
  end

  describe "#update!" do
    specify { expect { subject.update! }.to raise_error(NotImplementedError) }
  end

  describe "#refresh_character_access_token" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    before do
      #
      # Api::RefreshCharacterAccessToken.new(character).refresh
      #
      expect(Api::RefreshCharacterAccessToken).to receive(:new).with(character) do
        double.tap do |a|
          expect(a).to receive(:refresh)
        end
      end
    end

    specify { expect { subject.refresh_character_access_token }.not_to raise_error }
  end

  describe "#character_scope_present?" do
    context "when scope present" do
      let(:scope) { "esi-location.read_ship_type.v1" }

      let(:character) { instance_double(Character, scopes: "esi-location.read_location.v1 esi-location.read_ship_type.v1") }

      before { expect(subject).to receive(:character).and_return(character) }

      specify { expect(subject.character_scope_present?(scope)).to eq(true) }
    end

    context "when scope not present" do
      let(:scope) { "esi-location.read_ship_type.v1" }

      let(:character) { instance_double(Character, scopes: "") }

      before { expect(subject).to receive(:character).and_return(character) }

      specify { expect(subject.character_scope_present?(scope)).to eq(false) }
    end
  end
end
