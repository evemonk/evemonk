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
      character_portrait = ::EveOnline::ESI::CharacterPortrait.new(character_id: character.uid)

      character.update!(portrait_small: character_portrait.small,
                        portrait_medium: character_portrait.medium,
                        portrait_large: character_portrait.large,
                        portrait_huge: character_portrait.huge)
    end
  end
end
