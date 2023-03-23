# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesQuery do
  let(:order_by) { double }

  subject { described_class.new(order_by) }

  it { should be_a(BaseQuery) }

  describe "#initialize" do
    context "without order_by and scope" do
      let(:scope) { double }

      before { expect(Eve::Alliance).to receive(:all).and_return(scope) }

      subject { described_class.new }

      its(:order_by) { should eq(nil) }

      its(:scope) { should eq(scope) }
    end

    context "with order_by and scope" do
      let(:scope) { double }

      subject { described_class.new(order_by, scope) }

      its(:order_by) { should eq(order_by) }

      its(:scope) { should eq(scope) }
    end
  end
end
