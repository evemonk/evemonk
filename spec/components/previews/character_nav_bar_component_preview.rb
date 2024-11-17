# frozen_string_literal: true

class CharacterNavBarComponentPreview < Lookbook::Preview
  # @param id text
  def default(id: "1")
    character = Character.find(id)

    render CharacterNavBarComponent.new(character, "sheet")
  end

  # @param id text
  # @param current_page text
  def with_current_page(id: "1", current_page: "sheet")
    character = Character.find(id)

    render CharacterNavBarComponent.new(character, current_page)
  end
end
