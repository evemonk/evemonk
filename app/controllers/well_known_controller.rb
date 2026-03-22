# frozen_string_literal: true

class WellKnownController < ApplicationController
  def change_password
    redirect_to edit_user_registration_path, status: :moved_permanently
  end
end
