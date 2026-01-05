# frozen_string_literal: true

class CharacterWalletImporter < CharacterBaseImporter
  def import!
    resource.update!(wallet.as_json)
  end

  private

  def configure_esi_token
    @token = character_scope&.access_token
  end

  def character_scope
    @character_scope ||= resource.character_scopes.find_by(scope: scope)
  end

  def scope
    "esi-wallet.read_character_wallet.v1"
  end

  def client
    @client ||= EveOnline::ESI::Client.new(token: token, cache: true, cache_store: Rails.cache)
  end

  def wallet
    @wallet ||= client.wallet.character(id: id)
  end
end
