# frozen_string_literal: true

class CharacterAssetsImporter < CharacterBaseImporter
  attr_reader :page

  def initialize(character_id, page = 1)
    super(character_id)

    @page = page
  end

  def import!
    return unless character_scope_present?(esi.scope)

    destroy_old_character_assets(page)

    esi.assets.each do |asset|
      character.character_assets.create!(asset.as_json)
    end

    import_other_pages(esi.total_pages)
  end

  private

  def esi
    @esi ||= EveOnline::ESI::CharacterAssets.new(character_id: character.character_id,
                                                 token: character.access_token,
                                                 page: page)
  end

  def destroy_old_character_assets(page)
    return if page != 1

    character.character_assets.destroy_all
  end

  def import_other_pages(total_pages)
    return if page != 1 || total_pages == 1

    (2..total_pages).each do |next_page|
      CharacterAssetsJob.perform_later(character_id, next_page)
    end
  end
end
