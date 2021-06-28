# frozen_string_literal: true

class CharacterKillmailsImporter < CharacterBaseImporter
  attr_reader :page

  def initialize(character_id, page = 1)
    super(character_id)

    @page = page
  end

  def import!
    esi.killmails.each do |killmail|
      character.character_killmails.find_or_create_by!(killmail.as_json)
    end

    import_other_pages
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterKillmailsRecent.new(character_id: character.character_id,
      page: page)
  end

  private

  def import_other_pages
    return if page != 1 || esi.total_pages == 1

    (2..esi.total_pages).each do |next_page|
      CharacterKillmailsJob.perform_later(character_id, next_page)
    end
  end
end
