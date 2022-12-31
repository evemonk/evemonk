# frozen_string_literal: true

class CharacterBaseImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    return unless character_scope_present?

    refresh_character_access_token

    configure_middlewares

    configure_esi_token

    configure_etag

    return if esi.not_modified?

    ActiveRecord::Base.transaction do
      import!

      update_etag
    end
  rescue EveOnline::Exceptions::ResourceNotFound
    Rails.logger.info("WARNING: ESI response with 404 (NOT FOUND) for Character with ID #{character_id}")
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end

  def character
    @character ||= Character.lock.find_by!(character_id: character_id)
  end

  def esi
    raise NotImplementedError
  end

  def import!
    raise NotImplementedError
  end

  def refresh_character_access_token
    return unless character_scope_present?

    Api::RefreshCharacterAccessToken.new(character).refresh
  end

  def character_scope_present?
    if esi.scope.present?
      character.scopes.include?(esi.scope)
    else
      true
    end
  end

  def etag
    @etag ||= Etag.find_or_initialize_by(url: esi.url, character: character)
  end

  private

  def configure_middlewares
    esi.add_middleware(statistics_middleware)

    esi.add_middleware(cool_down_middleware)
  end

  def configure_esi_token
    return if esi.scope.blank?

    esi.token = character.access_token
  end

  def configure_etag
    esi.etag = etag.etag
  end

  def update_etag
    etag.update!(etag: esi.etag, body: esi.response)
  end

  def statistics_middleware
    {
      class: StatisticsMiddleware
    }
  end

  def cool_down_middleware
    {
      class: CoolDownMiddleware
    }
  end
end
