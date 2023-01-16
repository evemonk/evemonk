# frozen_string_literal: true

require "rails_helper"

describe CharacterAgents do
  let(:character) { double }

  let(:division_id) { double }

  subject { described_class.new(character, division_id) }

  describe "#initialize" do
    its(:character) { should eq(character) }

    its(:division_id) { should eq(division_id) }
  end
end
