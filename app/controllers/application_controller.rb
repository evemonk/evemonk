# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def not_authenticated
    redirect_to sign_in_path, alert: "Please login first"
  end
end
