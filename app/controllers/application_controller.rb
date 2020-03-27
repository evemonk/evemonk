# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!

  before_action :current_user_locale

  private

  def after_sign_in_path_for(_)
    characters_path
  end

  def current_user_locale
    if current_user
      if current_user.auto_detect?
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
      else
        I18n.locale = UserLocale.new(current_user.locale).to_locale
      end
    else
      I18n.locale = :en
    end
  end
end
