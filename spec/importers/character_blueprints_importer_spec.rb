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

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:json) { double }

    let(:blueprint) { instance_double(EveOnline::ESI::Models::Blueprint, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterBlueprints,
        blueprints: [blueprint])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    before { expect(subject).to receive(:destroy_old_character_blueprints) }

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

    before { expect(subject).to receive(:import_other_pages) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterBlueprints) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterBlueprints) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterBlueprints).to receive(:new).with(character_id: character_id, page: page).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end

  # private methods

  describe "#destroy_old_character_blueprints" do
    context "when page is first" do
      let(:page) { 1 }

      before do
        #
        # character.character_blueprints.destroy_all
        #
        expect(subject).to receive(:character) do
          double.tap do |a|
            expect(a).to receive(:character_blueprints) do
              double.tap do |b|
                expect(b).to receive(:destroy_all)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:destroy_old_character_blueprints) }.not_to raise_error }
    end

    context "when page is not first" do
      let(:page) { 2 }

      before { expect(subject).not_to receive(:character) }

      specify { expect { subject.send(:destroy_old_character_blueprints) }.not_to raise_error }
    end
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      before { expect(CharacterBlueprintsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:total_pages) { 1 }

      let(:esi) { instance_double(EveOnline::ESI::CharacterBlueprints, total_pages: total_pages) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(CharacterBlueprintsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:total_pages) { 2 }

      let(:esi) { instance_double(EveOnline::ESI::CharacterBlueprints, total_pages: total_pages) }

      before { expect(subject).to receive(:esi).and_return(esi).twice }

      before { expect(CharacterBlueprintsJob).to receive(:perform_later).with(character_id, 2) }

      specify { expect { subject.send(:import_other_pages) }.not_to raise_error }
    end
  end
end
