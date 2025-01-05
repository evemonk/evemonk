# frozen_string_literal: true

class CharacterWalletImporter < CharacterBaseImporter
  def import!
    character.update!(esi.as_json)
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterWallet.new(character_id: character.character_id)
  end
end
