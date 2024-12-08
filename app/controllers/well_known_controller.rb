# frozen_string_literal: true

class WellKnownController < ApplicationController
  skip_before_action :authenticate_user!

  def change_password
    skip_authorization

    redirect_to edit_user_registration_path, status: :moved_permanently
  end
end
