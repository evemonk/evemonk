# frozen_string_literal: true

class MailsController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @mail_labels = @character.character_mail_labels
  end
end
