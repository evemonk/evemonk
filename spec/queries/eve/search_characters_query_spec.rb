# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::SearchCharactersQuery do
  let(:q) { double }

  subject { described_class.new(q) }

  it { expect(subject).to be_a(BaseQuery) }

  describe "#initialize" do
    context "without q and scope" do
      let(:scope) { double }

      before { expect(Eve::Character).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:q) { is_expected.to eq(nil) }

      its(:scope) { is_expected.to eq(scope) }
    end

    context "with q and scope" do
      let(:scope) { double }

      subject { described_class.new(q, scope) }

      its(:q) { is_expected.to eq(q) }

      its(:scope) { is_expected.to eq(scope) }
    end
  end

  describe "#query" do
    context "when q is present" do
      let(:q) { "Green Black" }

      let!(:eve_character) { create(:eve_character, name: "Green Black") }

      let!(:index) { ActiveSearch.index(:eve_characters) }

      before { index.add(eve_character) }

      subject { described_class.new(q) }

      specify { expect(subject.query.to_a).to eq([eve_character]) }
    end

    context "when q is not present" do
      let(:q) { "" }

      let(:scope) { double }

      subject { described_class.new(q, scope) }

      specify { expect(subject.query).to eq(scope) }
    end
  end
end
