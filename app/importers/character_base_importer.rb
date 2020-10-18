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

    ActiveRecord::Base.transaction do
      update!
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

  def update!
    raise NotImplementedError
  end

  def refresh_character_access_token
    if character_scope_present?
      Api::RefreshCharacterAccessToken.new(character).refresh
    end
  end

  def character_scope_present?
    if esi.scope.present?
      character.scopes.include?(esi.scope)
    else
      true
    end
  end

  private

  def configure_middlewares
    esi.add_middleware(statistics_middleware)
  end

  def configure_esi_token
    if esi.scope.present?
      esi.token = character.access_token
    end
  end

  def statistics_middleware
    {
      class: StatisticsMiddleware,
      esi: esi
    }
  end

  # def cool_down_middleware
  #   {
  #     class: CoolDownMiddleware,
  #     esi: esi
  #   }
  # end
end
