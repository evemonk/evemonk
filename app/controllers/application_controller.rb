# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization

  protect_from_forgery with: :exception, prepend: true

  before_action :default_locale

  before_action :current_user_locale

  rescue_from Pundit::NotAuthorizedError, with: :redirect_user_to_root_path

  private

  def redirect_user_to_root_path
    redirect_to root_path
  end

  def after_sign_in_path_for(_)
    characters_path
  end

  def current_or_guest_user
    if user_signed_in?
      current_user
    else
      guest_user
    end
  end

  def guest_user
    @guest_user ||= begin
      User.find(cookies.permanent.signed[:guest_user_id] ||= User.guest.id)
    rescue ActiveRecord::RecordNotFound
      cookies.delete :guest_user_id

      User.guest
    end
  end

  def pundit_user
    current_or_guest_user
  end

  def default_locale
    I18n.locale = :en
  end

  def current_user_locale
    return if current_user.blank?

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
