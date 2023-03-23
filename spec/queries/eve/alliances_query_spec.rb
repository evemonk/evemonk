# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesQuery do
  let(:order_by) { double }

  subject { described_class.new(order_by) }

  it { should be_a(BaseQuery) }
end
