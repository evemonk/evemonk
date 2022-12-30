# frozen_string_literal: true

class EveOnlineCallbackService
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def save!
    ActiveRecord::Base.transaction do
      assign_character_attributes

      remove_old_characters

      character.save!
    end

    update_character_info

    import_missing_data

    # import_corporation_members
  end

  def name
    request.env.dig("omniauth.auth", "info", "name")
  end

  private

  def character_id
    request.env.dig("omniauth.auth", "info", "character_id")
  end

  def access_token
    request.env.dig("omniauth.auth", "credentials", "token")
  end

  def refresh_token
    request.env.dig("omniauth.auth", "credentials", "refresh_token")
  end

  def token_expires_at
    Time.zone.at(request.env.dig("omniauth.auth", "credentials", "expires_at"))
  end

  def token_expires
    request.env.dig("omniauth.auth", "credentials", "expires")
  end

  def scopes
    request.env.dig("omniauth.auth", "info", "scopes")
  end

  def token_type
    request.env.dig("omniauth.auth", "info", "token_type")
  end

  def character_owner_hash
    request.env.dig("omniauth.auth", "info", "character_owner_hash")
  end

  def character
    @character ||= user.characters.find_or_initialize_by(character_owner_hash: character_owner_hash)
  end

  def assign_character_attributes
    character.assign_attributes(name: name,
      access_token: access_token,
      refresh_token: refresh_token,
      token_expires_at: token_expires_at,
      token_expires: token_expires,
      scopes: scopes,
      token_type: token_type,
      character_id: character_id,
      esi_token_valid: true,
      esi_token_invalid_at: nil,
      esi_last_error: nil)
  end

  def remove_old_characters
    Character.where(character_id: character_id)
      .where.not(character_owner_hash: character_owner_hash)
      .destroy_all
  end

  def update_character_info
    UpdateCharacterInfoService.new(character_id).execute
  end

  def import_corporation_members
    CorporationMembersJob.perform_later(character_id)
  end

  def import_missing_data
    ImportMissing::Everything.new.import
  end
end
