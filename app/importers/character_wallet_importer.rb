# frozen_string_literal: true

class CharacterWalletImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterWallet.new(character_id: character_id,
                                              token: character.access_token)

    character.update!(esi.as_json)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
