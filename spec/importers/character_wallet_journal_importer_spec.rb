# frozen_string_literal: true

require "rails_helper"

describe CharacterWalletJournalImporter do
  let(:character_id) { double }

  let(:page) { double }

  subject { described_class.new(character_id, page) }

  it { should be_a(CharacterBaseImporter) }

  describe "#initialize" do
    context "when page not present" do
      subject { described_class.new(character_id) }

      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(1) }
    end

    context "when page is present" do
      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(page) }
    end
  end

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

      let(:wallet_journal_id) { double }

      let(:json) { double }

      let(:wallet_journal) do
        instance_double(EveOnline::ESI::Models::WalletJournal,
        wallet_journal_id: wallet_journal_id,
        as_json: json)
      end

      let(:total_pages) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterWalletJournal,
        wallet_journal_entries: [wallet_journal],
        scope: "esi-wallet.read_character_wallet.v1",
        total_pages: total_pages)
      end

      before { expect(EveOnline::ESI::CharacterWalletJournal).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      let(:character_wallet_journal) { instance_double(WalletJournal) }

      before do
        #
        # character.wallet_journals.find_or_initialize_by(wallet_journal_id: wallet_journal.wallet_journal_id)
        #
        expect(character).to receive(:wallet_journals) do
          double.tap do |a|
            expect(a).to receive(:find_or_initialize_by).with(wallet_journal_id: wallet_journal_id).and_return(character_wallet_journal)
          end
        end
      end

      before { expect(character_wallet_journal).to receive(:update!).with(json) }

      before { expect(subject).to receive(:import_other_pages).with(total_pages) }

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
        instance_double(EveOnline::ESI::CharacterWalletJournal,
          scope: "esi-wallet.read_character_wallet.v1")
      end

      before { expect(EveOnline::ESI::CharacterWalletJournal).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      before { expect(character).not_to receive(:wallet_journals) }

      before { expect(subject).not_to receive(:import_other_pages) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end

  # private methods

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      let(:total_pages) { 2 }

      before { expect(CharacterWalletJournalJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:total_pages) { 1 }

      before { expect(CharacterWalletJournalJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:total_pages) { 2 }

      before { expect(CharacterWalletJournalJob).to receive(:perform_later).with(character_id, 2) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end
  end
end
