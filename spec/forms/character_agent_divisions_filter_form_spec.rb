# frozen_string_literal: true

require "rails_helper"

describe CharacterAgentDivisionsFilterForm do
  it { should be_an(ActiveModel::Model) }

  let(:division_id) { double }

  subject { described_class.new(division_id) }

  describe "#initialize" do
    its(:division_id) { should eq(division_id) }
  end
end
