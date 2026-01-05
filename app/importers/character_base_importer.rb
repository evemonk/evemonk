# frozen_string_literal: true

class CharacterBaseImporter
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def import
    # return unless character_scope_present?

    refresh_character_access_token

    configure_middlewares

    # configure_esi_token

    ActiveRecord::Base.transaction do
      import!
    end
  rescue EveOnline::Exceptions::ResourceNotFound
    Rails.logger.info("WARNING: ESI response with 404 (NOT FOUND) for Character with ID #{id}")
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{id} not found")
  end

  def resource
    @resource ||= Character.lock.find_by!(character_id: id)
  end

  def client
    raise NotImplementedError
  end

  def import!
    raise NotImplementedError
  end

  def scope
    raise NotImplementedError
  end

  def refresh_character_access_token
    # return unless character_scope_present?

    Api::RefreshCharacterAccessToken.new(character).refresh
  end

  # def character_scope_present?
  #   if esi.scope.present?
  #     character.scopes.include?(esi.scope)
  #   else
  #     true
  #   end
  # end

  private

  def configure_middlewares
    client.add_middleware(statistics_middleware)

    client.add_middleware(cool_down_middleware)
  end

  # def configure_esi_token
  #   return if esi.scope.blank?
  #
  #   esi.token = character.access_token
  # end

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
