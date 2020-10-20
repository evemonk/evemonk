# frozen_string_literal: true

class CharacterMailLabelsImporter < CharacterBaseImporter
  def import!
    character.character_mail_labels.destroy_all

    character.update!(total_unread_count: esi.total_unread_count)

    esi.labels.each do |label|
      character.character_mail_labels.create!(label.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterMailLabels.new(character_id: character.character_id)
  end
end
