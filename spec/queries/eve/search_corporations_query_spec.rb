# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchCorporationsQuery do
  describe "#query" do
    let!(:eve_corporation) { create(:eve_corporation, name: "Freighting Solutions Inc.") }

    let!(:index) { ActiveSearch.index(:eve_corporations) }

    before { index.add(eve_corporation) }

    context "when q is present" do
      let(:q) { "Freighting Solutions Inc." }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_corporation]) }
    end

    context "when search is not present" do
      let(:q) { "" }

      subject { described_class.new(q: q) }

      specify { expect(subject.query.to_a).to eq([eve_corporation]) }
    end
  end
end
