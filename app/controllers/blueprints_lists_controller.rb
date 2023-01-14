# frozen_string_literal: true

class BlueprintsListsController < ApplicationController
  def index
    @character = current_user.characters
      .find_by!(character_id: params[:character_id])

    @form = CharacterStandingsFilterForm.new(params[:filter])

    @character_blueprints = @character.character_blueprints
      .joins(blueprint: :group)
      .order("eve_types.name_en": :asc)

    @character_blueprints =
      if params[:filter].present?
        case params[:filter]
        when "0"
          @character_blueprints
        when "1"
          @character_blueprints.where(quantity: -1)
        when "2"
          @character_blueprints.where(quantity: -2)
        when "3"
          @character_blueprints.where(eve_types: {eve_groups: {category_id: Eve::Categories::ANCIENT_RELICS_ID}})
        when "4"
          @character_blueprints.where(quantity: [0..])
        else
          @character_blueprints
        end
      else
        @character_blueprints
      end

    render layout: false
  end
end
