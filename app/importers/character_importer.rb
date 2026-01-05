# frozen_string_literal: true

class CharacterImporter < CharacterBaseImporter
  def import!
    resource.update!(character.as_json)
  end

  def scope
  end

  def client
    @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
  end

  def character
    @character ||= client.characters.retrieve(id: id)
  end
end
