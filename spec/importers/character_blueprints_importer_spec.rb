# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintsImporter do
  let(:character_id) { double }

  let(:page) { double }

  subject { described_class.new(character_id, page) }

  it { should be_a(CharacterBaseImporter) }

  describe "#initialize" do
    context "when page not present" do
      subject { described_class.new(character_id) }

      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(1) }
    end

    context "when page is present" do
      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(page) }
    end
  end

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-characters.read_blueprints.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:json) { double }

      let(:blueprint) { instance_double(EveOnline::ESI::Models::Blueprint, as_json: json) }

      let(:total_pages) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterBlueprints,
          blueprints: [blueprint],
          scope: "esi-characters.read_blueprints.v1",
          total_pages: total_pages)
      end

      before { expect(EveOnline::ESI::CharacterBlueprints).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      before { expect(subject).to receive(:destroy_old_character_blueprints).with(page) }

      before do
        #
        # character.character_blueprints.create!(blueprint.as_json)
        #
        expect(character).to receive(:character_blueprints) do
          double.tap do |a|
            expect(a).to receive(:create!).with(json)
          end
        end
      end

      before { expect(subject).to receive(:import_other_pages).with(total_pages) }

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
        instance_double(EveOnline::ESI::CharacterBlueprints,
          scope: "esi-characters.read_blueprints.v1")
      end

      before { expect(EveOnline::ESI::CharacterBlueprints).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      before { expect(character).not_to receive(:character_blueprints) }

      before { expect(subject).not_to receive(:import_other_pages) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end

  # private methods

  describe "#destroy_old_character_blueprints" do
    context "when page is first" # TODO: write

    context "when page is not first" # TODO: write
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      let(:total_pages) { 2 }

      before { expect(CharacterBlueprintsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:total_pages) { 1 }

      before { expect(CharacterBlueprintsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:total_pages) { 2 }

      before { expect(CharacterBlueprintsJob).to receive(:perform_later).with(character_id, 2) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end
  end
end
