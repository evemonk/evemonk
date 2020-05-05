# frozen_string_literal: true

class CharacterWalletTransactionsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterWalletTransactions.new(character_id: character.character_id,
                                                          token: character.access_token)

    return unless character_scope_present?(esi.scope)

    esi.wallet_transactions.each do |wallet_transaction|
      character_wallet_transaction = character.wallet_transactions.find_or_initialize_by(transaction_id: wallet_transaction.transaction_id)

      character_wallet_transaction.update!(wallet_transaction.as_json)
    end
  end
end
