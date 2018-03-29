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

      character_portrait

      character_attributes

      character_corporation_info

      character_loyalty_points
    end

    private

    def character_info
      info = ::EveOnline::ESI::Character.new(character_id: character.uid)

      # birthday: birthday

      character.update!(info.as_json)
    end

    def character_wallet
      wallet = ::EveOnline::ESI::CharacterWallet.new(character_id: character.uid,
                                                     token: character.token)

      character.update!(wallet.as_json)
    end

    def character_portrait
      portrait = ::EveOnline::ESI::CharacterPortrait.new(character_id: character.uid)

      character.update!(portrait_small: portrait.small,
                        portrait_medium: portrait.medium,
                        portrait_large: portrait.large,
                        portrait_huge: portrait.huge)
    end

    def character_attributes
      attributes = ::EveOnline::ESI::CharacterAttributes.new(character_id: character.uid,
                                                             token: character.token)

      character.update!(attributes.as_json)
    end

    def character_corporation_info
      corporation_id = character.corporation_id

      corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_id)

      corporation.update!(::EveOnline::ESI::Corporation.new(corporation_id: corporation_id).as_json)
    end

    def character_loyalty_points
      loyalty_points = ::EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.uid,
                                                                    token: character.token)

      ActiveRecord::Base.transaction do
        character.loyalty_points.destroy_all

        loyalty_points.loyalty_points.each do |lp|
          character.loyalty_points.create!(lp.as_json)
        end
      end
    end
  end
end
