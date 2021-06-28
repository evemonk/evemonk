# frozen_string_literal: true

class CharacterBlueprintsImporter < CharacterBaseImporter
  attr_reader :page

  def initialize(character_id, page = 1)
    super(character_id)

    @page = page
  end

  def import!
    destroy_old_character_blueprints

    esi.blueprints.each do |blueprint|
      character.character_blueprints.create!(blueprint.as_json)
    end

    import_other_pages
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterBlueprints.new(character_id: character.character_id,
      page: page)
  end

  private

  def destroy_old_character_blueprints
    return if page != 1

    character.character_blueprints.destroy_all
  end

  def import_other_pages
    return if page != 1 || esi.total_pages == 1

    (2..esi.total_pages).each do |next_page|
      CharacterBlueprintsJob.perform_later(character_id, next_page)
    end
  end
end
