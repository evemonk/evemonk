# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!

  before_action :default_locale

  before_action :current_user_locale

  private

  def after_sign_in_path_for(_)
    characters_path
  end

  def default_locale
    I18n.locale = :en
  end

  def current_user_locale
    return unless current_user

    I18n.locale = if current_user.auto_detect?
      http_accept_language.compatible_language_from(I18n.available_locales)
    else
      UserLocale.new(current_user.locale).to_locale
    end
  end

  # :nocov:
  if !Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan

      yield
    ensure
      Prosopite.finish
    end
  end
  # :nocov:
end
