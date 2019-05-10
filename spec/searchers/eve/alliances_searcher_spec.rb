# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesSearcher do
  describe '#initialize' do
    context 'with parameters' do
      let(:q) { double }

      let(:scope) { double }

      subject { described_class.new(q, scope) }

      its(:q) { should eq(q) }

      its(:scope) { should eq(scope) }
    end

    context 'without parameters' do
      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:q) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end
  end

  describe '#query' do
    xcontext 'when q is empty' do
      let!(:alliance1) { create(:eve_alliance) }

      let!(:alliance2) { create(:eve_alliance) }

      let!(:alliance3) { create(:eve_alliance) }

      subject { described_class.new }

      specify { expect(subject.query.count).to eq(3) }

      specify { expect(subject.query.respond_to?(:all)).to eq(true) }

      specify { expect(subject.query.to_a).to include(alliance1, alliance2, alliance3) }
    end

    xcontext 'when q is present' do
      context 'when name match' do
        let!(:alliance) { create(:eve_alliance, name: 'Northern Coalition.', ticker: nil) }

        let(:q) { 'Northern Coalition.' }

        before { Eve::Alliance.reindex }

        subject { described_class.new(q) }

        specify { expect(subject.query.to_a).to eq([alliance]) }
      end

      context 'when ticker match' do
        let!(:alliance) { create(:eve_alliance, name: nil, ticker: 'NC') }

        let(:q) { 'NC' }

        before { Eve::Alliance.reindex }

        subject { described_class.new(q) }

        specify { expect(subject.query.to_a).to eq([alliance]) }
      end
    end
  end
end
