# frozen_string_literal: true

class CharacterWalletImporter < CharacterBaseImporter
  def import!
    resource.update!(wallet.as_json)
  end

  def scope
    "esi-wallet.read_character_wallet.v1"
  end

  def client
    @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
  end

  def wallet
    @wallet ||= client.wallet.character(id: id)
  end
end
