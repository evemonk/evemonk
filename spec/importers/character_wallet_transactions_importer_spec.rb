# frozen_string_literal: true

require "rails_helper"

describe CharacterWalletTransactionsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do

    end

    context "when scope not present" do
      
    end
  end
end

