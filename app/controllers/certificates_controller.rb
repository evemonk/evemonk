# frozen_string_literal: true

class CertificatesController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @certificates_tree = CertificatesTree.new(@character)
  end
end
