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
    end

    private

    def character_info
      info = ::EveOnline::ESI::Character.new(character_id: character.uid)

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
  end
end
