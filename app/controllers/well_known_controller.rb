# frozen_string_literal: true

class WellKnownController < ApplicationController
  def change_password
    redirect_to edit_password_path(Current.user.password_reset_token), status: :moved_permanently
  end
end
