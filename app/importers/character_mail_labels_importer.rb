# frozen_string_literal: true

class CharacterMailLabelsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterMailLabels.new(character_id: character.character_id,
                                                  token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.character_mail_labels.destroy_all

    character.update!(total_unread_count: esi.total_unread_count)

    esi.labels.each do |label|
      character.character_mail_labels.create!(label.as_json)
    end
  end
end
