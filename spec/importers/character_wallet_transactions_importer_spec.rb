# frozen_string_literal: true

require "rails_helper"

describe CharacterWalletTransactionsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:transaction_id) { double }

    let(:json) { double }

    let(:wallet_transaction) do
      instance_double(EveOnline::ESI::Models::WalletTransaction,
        transaction_id: transaction_id,
        as_json: json)
    end

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterWalletTransactions,
        wallet_transactions: [wallet_transaction])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterWalletTransactions) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterWalletTransactions) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterWalletTransactions).to receive(:new).with({character_id: character_id}).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
