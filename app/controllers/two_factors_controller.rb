# frozen_string_literal: true

class TwoFactorsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.otp_secret = User.generate_otp_secret
    current_user.otp_required_for_login = true
    current_user.save!

    @codes = current_user.generate_otp_backup_codes!
  end

  def destroy

  end
end
