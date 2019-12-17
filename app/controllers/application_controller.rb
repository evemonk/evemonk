# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # before_action :current_user_locale

  private

  def after_sign_in_path_for(resource)
    characters_path
  end

  # def current_user_locale
  #   I18n.locale = :ru
  # end
end
