# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesSearcher do
  describe '#initialize' do
    context 'when scope present' do
      let(:q) { double }

      let(:scope) { double }

      subject { described_class.new(q, scope) }

      its(:q) { should eq(q) }

      its(:scope) { should eq(scope) }
    end

    context 'when scope not present' do
      let(:q) { double }

      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

      subject { described_class.new(q) }

      its(:q) { should eq(q) }

      its(:scope) { should eq(scope) }
    end
  end

  describe '#query' do
    context 'when q is empty' do
    end

    context 'when q is present' do
    end
  end
end
