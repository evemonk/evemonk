# frozen_string_literal: true

require "rails_helper"

describe Eve::ManufacturingItemsSearcher do
  describe "#initialize" do
    let(:query) { double }

    let(:scope) { double }

    context "with parameters" do
      subject { described_class.new(query, scope) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end

    context "without parameters" do
      before { expect(Eve::Type).to receive(:all).and_return(scope) }

      subject { described_class.new(query) }

      its(:query) { should eq(query) }

      its(:scope) { should eq(scope) }
    end
  end
end
