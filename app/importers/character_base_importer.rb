# frozen_string_literal: true

class CharacterBaseImporter
  attr_reader :id, :token

  def initialize(id)
    @id = id
  end

  def import
    configure_esi_token

    refresh_character_access_token

    configure_middlewares

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

  def scoped_token
    @scoped_token ||= resource.character_scopes.find_by(scope: scope)
  end

  def refresh_character_access_token
    return if scope.blank?

    Api::RefreshCharacterAccessToken.new(scoped_token).refresh
  end

  private

  def configure_middlewares
    client.add_middleware(statistics_middleware)

    client.add_middleware(cool_down_middleware)
  end

  def configure_esi_token
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
