# frozen_string_literal: true

class CharacterImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::Character.new(character_id: character_id)

    # FIXME: character security status always updates
    character.update!(esi.as_json)
  rescue EveOnline::Exceptions::ResourceNotFound
    character.destroy!
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
