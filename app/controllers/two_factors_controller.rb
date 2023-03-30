# frozen_string_literal: true

class TwoFactorsController < ApplicationController
  def show
  end

  def create
    @codes = current_user.generate_otp_backup_codes!

    current_user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    current_user.update!(
      otp_required_for_login: false,
      otp_secret: nil,
      otp_backup_codes: nil
    )

    respond_to do |format|
      format.turbo_stream
    end
  end
end
