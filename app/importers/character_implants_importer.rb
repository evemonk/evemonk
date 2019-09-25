# frozen_string_literal: true

class CharacterImplantsImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterImplants.new(character_id: character_id,
                                                token: character.access_token)

    ActiveRecord::Base.transaction do
      character.character_implants.destroy_all

      esi.implant_ids.each do |implant_id|
        character.character_implants.create!(type_id: implant_id)
      end
    end
  rescue EveOnline::Exceptions::Forbidden
    Api::RefreshCharacterAccessToken.new(character_id).refresh
  end
end
