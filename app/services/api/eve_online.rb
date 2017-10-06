module Api
  class EveOnline
    attr_reader :request, :session

    delegate :errors, to: :character

    def initialize(request)
      @request = request
    end

    def save!
      update_character_attributes

      create_user

      character.save!

      create_session

      update_character_info
    end

    private

    def uid
      request.env['omniauth.auth']['info']['character_id']
    end

    def name
      request.env['omniauth.auth']['info']['name']
    end

    def token
      request.env['omniauth.auth']['credentials']['token']
    end

    def refresh_token
      request.env['omniauth.auth']['credentials']['refresh_token']
    end

    def token_expires_at
      Time.zone.at(request.env['omniauth.auth']['credentials']['expires_at'])
    end

    def token_expires
      request.env['omniauth.auth']['credentials']['expires']
    end

    def scopes
      request.env['omniauth.auth']['info']['scopes']
    end

    def token_type
      request.env['omniauth.auth']['info']['token_type']
    end

    def character
      @character ||= Character.find_or_initialize_by(uid: uid)
    end

    def update_character_attributes
      character.assign_attributes(name: name,
                                  token: token,
                                  refresh_token: refresh_token,
                                  token_expires_at: token_expires_at,
                                  token_expires: token_expires,
                                  scopes: scopes,
                                  token_type: token_type)
    end

    def create_user
      character.create_user!(kind: :oauth) unless character.user
    end

    def create_session
      @session = character.user.sessions.create!
    end

    def update_character_info
      Api::UpdateCharacterInfo.new(character, character.token).update!
    end
  end
end
