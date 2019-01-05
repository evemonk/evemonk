# frozen_string_literal: true

module Api
  class EveOnlineForm
    attr_reader :request

    # delegate :errors, to: :character

    def initialize(request)
      @request = request
    end

    def save!
    end

    # def save
    #   update_character_attributes

    #   build_user

    #   character.save!

    #   session.save!

    #   update_character_info
    # end

    # def session
    #   @session ||= character.user.sessions.build
    # end

    def session
      @session ||= Session.new
    end

    # private

    # def character_id
    #   request.env['omniauth.auth']['info']['character_id']
    # end

    # def name
    #   request.env['omniauth.auth']['info']['name']
    # end

    # def access_token
    #   request.env['omniauth.auth']['credentials']['token']
    # end

    # def refresh_token
    #   request.env['omniauth.auth']['credentials']['refresh_token']
    # end

    # def token_expires_at
    #   Time.zone.at(request.env['omniauth.auth']['credentials']['expires_at'])
    # end

    # def token_expires
    #   request.env['omniauth.auth']['credentials']['expires']
    # end

    # def scopes
    #   request.env['omniauth.auth']['info']['scopes']
    # end

    # def token_type
    #   request.env['omniauth.auth']['info']['token_type']
    # end

    # def character_owner_hash
    #   request.env['omniauth.auth']['info']['character_owner_hash']
    # end

    # def character
    #   @character ||= Character.find_or_initialize_by(character_id: character_id)
    # end

    # def update_character_attributes
    #   character.assign_attributes(name: name,
    #                               access_token: access_token,
    #                               refresh_token: refresh_token,
    #                               token_expires_at: token_expires_at,
    #                               token_expires: token_expires,
    #                               scopes: scopes,
    #                               token_type: token_type,
    #                               character_owner_hash: character_owner_hash)
    # end

    # def build_user
    #   character.build_user(kind: :oauth) unless character.user
    # end

    # def update_character_info
    #   CharacterImporter.new(character_id).import
    # end
  end
end
