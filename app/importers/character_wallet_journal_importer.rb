# frozen_string_literal: true

class CharacterWalletJournalImporter < CharacterBaseImporter
  attr_reader :page

  def initialize(character_id, page = 1)
    super(character_id)

    @page = page
  end

  def import!
    esi.wallet_journal_entries.each do |wallet_journal|
      character_wallet_journal = character.wallet_journals.find_or_initialize_by(wallet_journal_id: wallet_journal.wallet_journal_id)

      character_wallet_journal.update!(wallet_journal.as_json)
    end

    import_other_pages
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterWalletJournal.new(character_id: character.character_id,
      page: page)
  end

  private

  def import_other_pages
    return if page != 1 || esi.total_pages == 1

    (2..esi.total_pages).each do |next_page|
      CharacterWalletJournalJob.perform_later(character_id, next_page)
    end
  end
end
