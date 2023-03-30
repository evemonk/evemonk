# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def pre_otp
      @user = User.find_or_initialize_by(email: pre_otp_params[:email].downcase.strip)

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def pre_otp_params
      params.require(:user).permit(:email)
    end
  end
end
