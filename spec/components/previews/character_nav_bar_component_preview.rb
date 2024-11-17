# frozen_string_literal: true

class CharacterNavBarComponentPreview < Lookbook::Preview
  def default
    character = FactoryBot.build_stubbed(:character)

    render CharacterNavBarComponent.new(character, "sheet")
  end

  # @param id text
  # @param current_page text
  def with_real_character(id: "1", current_page: "sheet")
    character = Character.find(id)

    render CharacterNavBarComponent.new(character, current_page)
  end

  # @param current_page text
  def with_current_page(current_page: "sheet")
    character = FactoryBot.build_stubbed(:character)

    render CharacterNavBarComponent.new(character, current_page)
  end
end
