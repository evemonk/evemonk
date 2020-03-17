# frozen_string_literal: true

class WalletJournalsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    # @wallet_journals = @character.wallet_journals
    #   .page(params[:page])
    #   .per(100)
  end
end
