# frozen_string_literal: true

class CharacterWalletTransactionsImporter < CharacterBaseImporter
  def import!
    esi.wallet_transactions.each do |wallet_transaction|
      character_wallet_transaction = character.wallet_transactions.find_or_initialize_by(transaction_id: wallet_transaction.transaction_id)

      character_wallet_transaction.update!(wallet_transaction.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterWalletTransactions.new(character_id: character.character_id)
  end
end
