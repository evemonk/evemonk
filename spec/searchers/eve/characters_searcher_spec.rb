# frozen_string_literal: true

require "rails_helper"

describe Eve::CharactersSearcher do
  describe "#initialize" do
    context "with parameters" do
      let(:query) { double }

      let(:scope) { double }

      subject { described_class.new(query, scope) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end

    context "without parameters" do
      let(:scope) { double }

      before { expect(Eve::Character).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:query) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end
  end

  describe "#search" do
    context "when query is empty" do
      let!(:character1) { create(:eve_character, name: "a") }

      let!(:character2) { create(:eve_character, name: "b") }

      let!(:character3) { create(:eve_character, name: "c") }

      subject { described_class.new }

      specify { expect(subject.search.count).to eq(3) }

      specify { expect(subject.search.respond_to?(:all)).to eq(true) }

      specify { expect(subject.search.to_a).to eq([character1, character2, character3]) }
    end

    context "when query is present" do
      context "when name match" do
        let!(:character) do
          create(:eve_character,
                 name: "Green Black")
        end

        let(:query) { "Green Black" }

        before { Eve::Character.reindex }

        subject { described_class.new(query) }

        specify { expect(subject.search.to_a).to eq([character]) }
      end
    end
  end
end
