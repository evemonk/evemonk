# frozen_string_literal: true

module Api
  class UpdateCharacterInfo
    attr_reader :character

    def initialize(character)
      @character = character
    end

    def update!
      character_info

      character_wallet

      character_attributes

      # character_loyalty_points
    end

    private

    def character_info
      esi = EveOnline::ESI::Character.new(character_id: character.character_id)

      character.update!(esi.as_json)
    end

    def character_wallet
      esi = EveOnline::ESI::CharacterWallet.new(character_id: character.character_id,
                                                token: character.access_token)

      character.update!(esi.as_json)
    end

    def character_attributes
      attributes = EveOnline::ESI::CharacterAttributes.new(character_id: character.character_id,
                                                           token: character.access_token)

      character.update!(attributes.as_json)
    end

    # def character_loyalty_points
    #   loyalty_points = EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.character_id,
    #                                                               token: character.access_token)

    #   ActiveRecord::Base.transaction do
    #     character.loyalty_points.destroy_all

    #     loyalty_points.loyalty_points.each do |lp|
    #       character.loyalty_points.create!(lp.as_json)
    #     end
    #   end
    # end
  end
end
