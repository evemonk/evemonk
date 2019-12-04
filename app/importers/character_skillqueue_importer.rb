# frozen_string_literal: true

class CharacterSkillqueueImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterSkillQueue.new(character_id: character.character_id,
                                                  token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.skillqueues.destroy_all

    esi.skills.each do |skill|
      character.skillqueues.create!(skill.as_json)
    end
  end
end
