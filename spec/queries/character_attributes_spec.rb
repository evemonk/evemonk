# frozen_string_literal: true

require "rails_helper"

describe CharacterAttributes do
  describe "#initialize" do
    let(:character) do
      build(:character,
        perception: 23,
        memory: 24,
        willpower: 23,
        intelligence: 24,
        charisma: 20)
    end

    subject { described_class.new(character) }

    its(:character) { should eq(character) }
  end
end
