# frozen_string_literal: true

class BlueprintsListsController < ApplicationController
  def index
    @character = current_user.characters
      .find_by!(character_id: params[:character_id])

    @form = CharacterStandingsFilterForm.new(params[:filter])

    @character_blueprints = @character.character_blueprints
      .includes(blueprint: :group)
      .order("eve_types.name_en": :asc)

    render layout: false
  end
end
