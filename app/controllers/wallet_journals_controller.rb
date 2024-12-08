# frozen_string_literal: true

class WalletJournalsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @wallet_journals = @character.wallet_journals
      .page(params[:page])
      .per(10)
  end
end
