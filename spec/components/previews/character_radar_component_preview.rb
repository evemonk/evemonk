# frozen_string_literal: true

class CharacterRadarComponentPreview < Lookbook::Preview
  # @param id text
  def default(id: "1")
    character = Character.find(id)

    render CharacterRadarComponent.new(character)
  end
end
