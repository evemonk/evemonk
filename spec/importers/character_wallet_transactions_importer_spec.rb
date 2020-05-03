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
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterWalletTransactions,
          scope: "esi-wallet.read_character_wallet.v1")
      end

      before { expect(EveOnline::ESI::CharacterWalletTransactions).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:wallet_transactions) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
