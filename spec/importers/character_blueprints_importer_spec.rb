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
    # TODO: write
  end

  # private methods

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
