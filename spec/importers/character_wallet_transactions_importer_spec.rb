# frozen_string_literal: true

require "rails_helper"

describe CharacterWalletTransactionsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-wallet.read_character_wallet.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:transaction_id) { double }

      let(:json) { double }

      let(:wallet_transaction) do
        instance_double(EveOnline::ESI::Models::WalletTransaction,
          transaction_id: transaction_id,
          as_json: json)
      end

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterWalletTransactions,
          wallet_transactions: [wallet_transaction],
          scope: "esi-wallet.read_character_wallet.v1")
      end

      before { expect(EveOnline::ESI::CharacterWalletTransactions).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      let(:character_wallet_transaction) { instance_double(WalletTransaction) }

      before do
        #
        # character.wallet_transactions.find_or_initialize_by(transaction_id: wallet_transaction.transaction_id)
        #
        expect(character).to receive(:wallet_transactions) do
          double.tap do |a|
            expect(a).to receive(:find_or_initialize_by).with(transaction_id: transaction_id)
              .and_return(character_wallet_transaction)
          end
        end
      end

      before { expect(character_wallet_transaction).to receive(:update!).with(json) }

      specify { expect { subject.update! }.not_to raise_error }
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
