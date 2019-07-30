# frozen_string_literal: true

module Api
  class EveOnlineForm
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def save!
      ActiveRecord::Base.transaction do
        assign_character_attributes

        build_user

        remove_old_characters

        character.save!

        session.save!

        update_character_info

        # update_character_wallet

        # update_character_attributes

        # update_character_lps
      end
    end

    def session
      @session ||= character.user.sessions.build
    end

    private

    def character_id
      request.env.dig("omniauth.auth", "info", "character_id")
    end

    def name
      request.env.dig("omniauth.auth", "info", "name")
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
      @character ||= Character.find_or_initialize_by(character_owner_hash: character_owner_hash)
    end

    def assign_character_attributes
      character.assign_attributes(name: name,
                                  access_token: access_token,
                                  refresh_token: refresh_token,
                                  token_expires_at: token_expires_at,
                                  token_expires: token_expires,
                                  scopes: scopes,
                                  token_type: token_type,
                                  character_id: character_id)
    end

    def build_user
      character.build_user(kind: :oauth) unless character.user
    end

    def remove_old_characters
      return unless character.new_record?

      Character.where(character_id: character_id).destroy_all
    end

    def update_character_info
      Api::UpdateCharacterInfo.new(character).update!
    end

    # TODO: remove this
    # def update_character_info
    #   CharacterImporter.new(character_id).import
    # end

    # def update_character_wallet
    #   CharacterWalletImporter.new(character_id).import
    # end

    # def update_character_attributes
    #   CharacterAttributesImporter.new(character_id).import
    # end

    # def update_character_lps
    #   CharacterLoyaltyPointsImporter.new(character_id).import
    # end
  end
end
