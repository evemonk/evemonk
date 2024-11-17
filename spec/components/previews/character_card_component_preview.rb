# frozen_string_literal: true

class CharacterCardComponentPreview < Lookbook::Preview
  # @param id text
  def default(id: "1")
    character = Character.find(id)

    render CharacterCardComponent.new(character)
  end

  # @param id text
  def full(id: "1")
    character = Character.find(id)

    render CharacterCardComponent.new(character, full: true)
  end
end
