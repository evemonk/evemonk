# frozen_string_literal: true

class CharacterKillmailsImporter < CharacterBaseImporter
  attr_reader :page

  def initialize(character_id, page = 1)
    super(character_id)

    @page = page
  end

  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterKillmailsRecent.new(character_id: character.character_id,
                                                       token: character.access_token,
                                                       page: page)

    return unless character_scope_present?(esi.scope)

    esi.killmails.each do |killmail|
      character.character_killmails.find_or_create_by(killmail.as_json)
    end

    import_other_pages(esi.total_pages)
  end

  private

  def import_other_pages(total_pages)
    return if page != 1 || total_pages == 1

    (2..total_pages).each do |next_page|
      CharacterKillmailsJob.perform_later(character_id, next_page)
    end
  end
end
