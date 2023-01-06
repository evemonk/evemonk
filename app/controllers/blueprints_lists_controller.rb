# frozen_string_literal: true

class BlueprintsListsController < ApplicationController
  def index
    @character = current_user.characters
      .find_by!(character_id: params[:character_id])

    @character_blueprints = @character.character_blueprints
      .includes(blueprint: :group)

    render layout: false
  end
end
