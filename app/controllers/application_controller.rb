# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  include Pundit::Authorization

  protect_from_forgery with: :exception, prepend: true

  before_action :default_locale

  before_action :current_user_locale

  rescue_from Pundit::NotAuthorizedError, with: :redirect_user_to_root_path

  private

  def pundit_user
    Current.user
  end

  def redirect_user_to_root_path
    redirect_to root_path
  end

  def default_locale
    I18n.locale = :en
  end

  def current_user_locale
    return if !authenticated?

    I18n.locale = if Current.user.auto_detect?
      http_accept_language.compatible_language_from(I18n.available_locales)
    else
      UserLocale.new(Current.user.locale).to_locale
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
