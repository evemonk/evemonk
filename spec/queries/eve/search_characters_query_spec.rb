# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchCharactersQuery do
  describe "#query" do
    let!(:eve_character) { create(:eve_character, name: "Green Black") }

    let!(:index) { ActiveSearch.index(:eve_characters) }

    before { index.add(eve_character) }

    context "when q is present" do
      let(:q) { "Green Black" }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_character]) }
    end

    context "when q is not present" do
      let(:q) { "" }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_character]) }
    end
  end
end
