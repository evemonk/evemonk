# frozen_string_literal: true

class CertificatesController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @character_certificates_tree = CharacterCertificatesTree.new(@character).preload
  end
end
