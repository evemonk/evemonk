# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchAlliancesQuery do
  describe "#query" do
    let!(:eve_alliance) { create(:eve_alliance, name: "The Dead Parrots") }

    let!(:index) { ActiveSearch.index(:eve_alliances) }

    before { index.add(eve_alliance) }

    context "when q is present" do
      let(:q) { "The Dead Parrots" }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_alliance]) }
    end

    context "when q is not present" do
      let(:q) { "" }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_alliance]) }
    end
  end
end
