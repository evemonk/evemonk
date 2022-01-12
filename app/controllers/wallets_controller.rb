# frozen_string_literal: true

class WalletsController < ApplicationController
  def update
    character = current_user.characters.find_by!(character_id: params[:character_id])

    CharacterWalletJob.perform_later(character.character_id)

    head :ok
  end
end
