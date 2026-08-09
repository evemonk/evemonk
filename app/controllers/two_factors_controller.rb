# frozen_string_literal: true

class TwoFactorsController < ApplicationController
  before_action :authenticate_user!

  def create
    @codes = current_user.generate_otp_backup_codes!

    current_user.otp_secret = User.generate_otp_secret
    current_user.otp_required_for_login = true
    current_user.save!
  end

  def destroy
    current_user.otp_required_for_login = false
    current_user.save!
  end
end
